#!/bin/bash
tmux has-session -t mitmproxy
if [ $? != 0 ]; then
    tmux new-session -s mitmproxy -d
    tmux send-keys -t mitmproxy 'APP_UID=10154 # modify this line' C-m
    tmux send-keys -t mitmproxy 'sudo iptables-legacy -t nat -A OUTPUT -p tcp --dport 80 -m owner --uid-owner $APP_UID -j DNAT --to 127.0.0.1:8080' C-m
    tmux send-keys -t mitmproxy 'sudo iptables-legacy -t nat -A OUTPUT -p tcp --dport 443 -m owner --uid-owner $APP_UID -j DNAT --to 127.0.0.1:8080' C-m
    tmux send-keys -t mitmproxy 'mitmproxy --mode transparent' C-m
fi
