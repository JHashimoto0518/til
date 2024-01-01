---
bibliography:
  - https://xunit.net/docs/getting-started/netcore/visual-studio
  - https://qiita.com/kojimadev/items/c451196fb703cbf99e86
  - https://www.lambdatest.com/blog/nunit-vs-xunit-vs-mstest/
repositoryUrl:
  - https://github.com/JHashimoto0518/csharp-exercise/tree/main/xunit-sample
draft: false
---

# xUnitでテストを実装するには

Calculator.cs:

```csharp
namespace Calc {
    public class Calculator {
        public int Add(int x, int y) {
            return x + y;
        }
    }
}
```

CalcTests.cs:

```csharp
namespace Calc.Tests {
    public class CalcTests {

        public CalcTests() {
            // If you need to do some setup before each test, do it here. Because xUnit doesn't have [SetUp] and [TearDown] attributes.
        }

        [Fact]
        public void Add() {
            var c = new Calculator();
            var actual = c.Add(2, 2);
            var expected = 4;
            Assert.Equal(expected, actual);
        }
    }
}
```
