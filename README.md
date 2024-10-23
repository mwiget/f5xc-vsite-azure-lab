# f5xc-vsite-azure-lab

```
                  ......................         ......................
                  .      vsite-1       .         .       vsite-2      .
+-------------+   .       +----------+ .         . +----------+       .   +-------------+
| workload-1a |   .       | vsite-1a | .         . | vsite-2a |       .   | workload-2a |
+-------------+   . +---+ +----------+ .         . +----------+ +---+ .   +-------------+
                  . |lnb|              .         .              |nlb| .
+-------------+   . +---+ +----------+ .         . +----------+ +---+ .   +-------------+
| workload-1b |   .       | vsite-1b | .         . | vsite-2b |       .   | workload-2b |
+-------------+   .       +----------+ .         . +----------+       .   +-------------+
                  ......................         ......................
```

```
$ terraform init
$ terraform apply
ip_address = [
  {
    "mw-azure-vsite-11-m0-public" = "203.0.234.205"
    "mw-azure-vsite-11-m0-sli" = "10.1.11.4"
    "mw-azure-vsite-11-m0-slo" = "10.1.1.4"
    "mw-azure-vsite-11-sli-workload" = "203.0.159.91"
  },
  {
    "mw-azure-vsite-12-m0-public" = "203.0.74.212"
    "mw-azure-vsite-12-m0-sli" = "10.1.11.5"
    "mw-azure-vsite-12-m0-slo" = "10.1.1.5"
    "mw-azure-vsite-12-sli-workload" = "203.0.50.100"
  },
  {
    "mw-azure-vsite-21-m0-public" = "203.0.153.25"
    "mw-azure-vsite-21-m0-sli" = "10.2.11.4"
    "mw-azure-vsite-21-m0-slo" = "10.2.1.5"
    "mw-azure-vsite-21-sli-workload" = "203.0.143.7"
  },
  {
    "mw-azure-vsite-22-m0-public" = "203.0.12.120"
    "mw-azure-vsite-22-m0-sli" = "10.2.11.5"
    "mw-azure-vsite-22-m0-slo" = "10.2.1.4"
    "mw-azure-vsite-22-sli-workload" = "203.0.65.234"
  },
]
load_balancer = {
  "vsite1" = [
    "10.1.1.6",
    "10.1.11.6",
  ]
  "vsite2" = [
    "10.2.1.6",
    "10.2.11.6",
  ]
}
```
