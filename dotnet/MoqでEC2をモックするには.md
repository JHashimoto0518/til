---
bibliography: 
repositoryUrl:
    - https://github.com/JHashimoto0518/csharp-exercise/tree/main/aws-sample
draft: false
---

# MoqでEC2をモックするには

```csharp
Mock<IAmazonEC2> ec2ClientMock = new Mock<IAmazonEC2>();

ec2ClientMock
    .Setup(x => x.DescribeInstancesAsync(
        It.IsAny<CancellationToken>()))
    .ReturnsAsync(
        (CancellationToken ct) =>
        new DescribeInstancesResponse
        {
            Reservations = new List<Reservation> {
                new Reservation {
                    Instances = new List<Instance> {
                        new Instance {
                            InstanceId = "i-abcdefg0123456789",
                            InstanceType = "c5.large",
                            Tags = new List<Amazon.EC2.Model.Tag> {
                                new Tag() {
                                    Key = "Name",
                                    Value = "ec2-webserver"
                                }
                            }
                        }
                    }
                }
            }
        });

IAmazonEC2 ec2Client = ec2ClientMock.Object;

var ins = ec2Client.DescribeInstancesAsync().Result.Reservations.First().Instances.First();

// Name: ec2-webserver, Id: i-abcdefg0123456789, InstanceType: c5.large
Console.WriteLine($"Name: {ins.Tags.Where(t => t.Key == "Name").First().Value}, Id: {ins.InstanceId}, InstanceType: {ins.InstanceType}");
```
