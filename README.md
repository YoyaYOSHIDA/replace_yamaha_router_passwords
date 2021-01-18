# README.md

Replaces password strings to dummies for security reasons to maintain configurations of Yamaha router such as RTX1210 on Git.

## Remark

Tested on MacOS.

## How this works

Berore

`foo123`, `bar456`. `baz789` are your plain passwords.

```
# RTX1210 Rev.xx.xx.xx
# MAC Address : xx:xx:xx:xx:xx:xx, xx:xx:xx:xx:xx:xx, xx:xx:xx:xx:xx:xx
...
pp select 2
 pp auth myname xxx@example.com foo123
...
pp select anonymous
 ...
 pp auth username b.sanders bar456
 pp auth username j.davis baz789
...
tunnel select 1
  ...
  ipsec ike pre-shared-key 1 text foo123
...
radius secret bar456
...
cloud vpn parameter 1 baz789 foo123 bar456
...
EOF
```

After

All secure string is replaced to `xxxxxxxx`.

```
# RTX1210 Rev.xx.xx.xx
# MAC Address : xx:xx:xx:xx:xx:xx, xx:xx:xx:xx:xx:xx, xx:xx:xx:xx:xx:xx
...
pp select 2
 pp auth myname xxx@example.com xxxxxxxx
...
pp select anonymous
 ...
 pp auth username b.sanders xxxxxxxx
 pp auth username j.davis xxxxxxxx
...
tunnel select 1
  ...
  ipsec ike pre-shared-key 1 text xxxxxxxx
...
radius secret xxxxxxxx
...
cloud vpn parameter 1 xxxxxxxx
...
EOF
```

## How to use

```bash
chmod 700 replace_yamaha_router_passwords.sh
./replace_yamaha_router_passwords.sh <config_before_replacing.txt> \
> <config_after_replacing.txt>
```

