---
draft: true
---

# Enumにプロパティを持たせるには

https://tech.uzabase.com/entry/2023/12/03/100712

> 言語によって実装手段は様々考えられます。Kotlin(Java)であればenumにプロパティを定義することができるため、表を直接的に表現することができます。

C#で同じことを実現する場合、Enum にはプロパティを実装できないため、代替として属性 (attribute) を利用する。

```cs
enum SubscriptionPlan {
    [BillingPromotionFeatureEnabled(false)]
    [LimitedContentAccessible(false)]
    [DiscountPromotionEnabled(false)]
    [StudentVerificationRequired(false)]
    Free,
    [BillingPromotionFeatureEnabled(true)]
    [LimitedContentAccessible(true)]
    [DiscountPromotionEnabled(true)]
    [StudentVerificationRequired(false)]
    Monthly,
    [BillingPromotionFeatureEnabled(true)]
    [LimitedContentAccessible(true)]
    [DiscountPromotionEnabled(false)]
    [StudentVerificationRequired(false)]
    Yearly,
    [BillingPromotionFeatureEnabled(true)]
    [LimitedContentAccessible(false)]
    [DiscountPromotionEnabled(false)]
    [StudentVerificationRequired(true)]
    Student
}

internal class BillingPromotionFeatureEnabledAttribute(bool enabled) : EnumEnableAttributeBase(enabled) {
}

internal class LimitedContentAccessibleAttribute(bool enabled) : EnumEnableAttributeBase(enabled) {
}

[AttributeUsage(AttributeTargets.Field)]
abstract internal class EnumEnableAttributeBase(bool enabled) : Attribute {
    public bool Enabled { get; } = enabled;
}
```

次に、属性を元に判定するメソッドを用意する。

Enum はメソッドの実装をサポートしていないため、拡張メソッドを利用する。拡張メソッドは既存クラスのコードを変更せずに、メソッドを追加する機能。

なお、属性の設定漏れは、例外で検知するようにした。

```cs
// SubscriptionPlanの拡張メソッドを定義する
static class SubscriptionPlanExtensions {

    public static bool IsBillingPromotionFeatureEnabled(this SubscriptionPlan self) {
        return IsEnabled<BillingPromotionFeatureEnabledAttribute>(self);
    }

    public static bool IsLimitedContentAccessible(this SubscriptionPlan self) {
        return IsEnabled<LimitedContentAccessibleAttribute>(self);
    }

    public static bool IsDiscountPromotionEnabled(this SubscriptionPlan self) {
        return IsEnabled<DiscountPromotionEnabledAttribute>(self);
    }

    public static bool IsStudentVerificationRequired(this SubscriptionPlan self) {
        return IsEnabled<StudentVerificationRequiredAttribute>(self);
    }
    private static bool IsEnabled<T>(SubscriptionPlan self) where T : EnumEnableAttributeBase {
        var planName = Enum.GetName(typeof(SubscriptionPlan), self)!;
        var plan = self.GetType().GetField(planName)!;

        T attr = plan.GetCustomAttributes(typeof(T), inherit: false).Cast<T>().FirstOrDefault() ??
            throw new InvalidOperationException($"Attribute {typeof(T).Name} is not defined for {planName}.");

        return attr.Enabled;
    }

}
```

判定メソッドを利用して、条件分岐する。

```cs
if (subscriptionPlan.IsBillingPromotionFeatureEnabled()) {
    ...
```

## Todo

リフレクションが遅延の原因になっていないか？

- https://postd.cc/why-is-reflection-slow/
- https://ufcpp.net/study/csharp/misc_dynamic.html
