---
bibliography: 
repositoryUrl:
draft: true
---

# DeprecationWarning-of-datetime.datetime.utcfromtimestamp

Python 3.12 では、`datetime.datetime.utcfromtimestamp` が非推奨になった。

```bash
..\..\..\..\..\..\Users\xxx\AppData\Local\Programs\Python\Python312\Lib\site-packages\dateutil\tz\tz.py:37
  D:\Users\xxx\AppData\Local\Programs\Python\Python312\Lib\site-packages\dateutil\tz\tz.py:37: DeprecationWarning: datetime.datetime.utcfromtimestamp() is deprecated and scheduled for removal in a future version. Use timezone-aware objects to repre
sent datetimes in UTC: datetime.datetime.fromtimestamp(timestamp, datetime.UTC).
    EPOCH = datetime.datetime.utcfromtimestamp(0)

-- Docs: https://docs.pytest.org/en/stable/how-to/capture-warnings.html
```

https://docs.pytest.org/en/stable/how-to/capture-warnings.html
