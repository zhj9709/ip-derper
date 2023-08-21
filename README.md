# Setup

```bash
docker run -d --name ip-derper -p 50443:443 -p 3478:3478/udp zhj9709/ip-derper
```

| env                 | required | description                                                            | default value     |
| ------------------- | -------- | ---------------------------------------------------------------------- | ----------------- |
| DERP_CERT_DIR       | false    | directory to store LetsEncrypt certs(if addr's port is :443)           | /app/certs        |
| DERP_ADDR           | false    | listening server address                                               | :443              |
| DERP_STUN           | false    | also run a STUN server                                                 | true              |
| DERP_STUN_PORT      | false    | The UDP port on which to serve STUN.                                   | 3478              |
| DERP_HTTP_PORT      | false    | The port on which to serve HTTP. Set to -1 to disable                  | 80                |
| DERP_VERIFY_CLIENTS | false    | verify clients to this DERP server through a local tailscaled instance | false             |

# Usage

inserts this into tailscale ACLs: https://login.tailscale.com/admin/acls
```json
"derpMap": {
    "Regions": {
        "900": {
            "RegionID": 900,
            "RegionCode": "my_private_derper",
            "Nodes": [
                {
                    "Name": "1",
                    "RegionID": 900,
                    "HostName": "YOUR_SERVER_IP",
                    "IPv4": "YOUR_SERVER_IP",
                    "InsecureForTests": true,
                    "DERPPort": 50443
                }
            ]
        }
    }
}
```

