# Leds
To disable leds edit the following file

```bash
sudo nano /boot/firmware/config.txt
```

To disable the green status led add these lines
```bash
dtparam=act_led_trigger=none
dtparam=act_led_activelow=off
```

To disable the eth0 leds add these lines
```bash
dtparam=eth_led0=4
dtparam=eth_led1=4
```