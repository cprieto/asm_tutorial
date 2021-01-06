%define SYS_FORK 2
%define SYS_READ 3
%define SYS_WRITE 4
%define SYS_CLOSE 6
%define SYS_SOCKETCALL 102

; socket operations
%define SOCKET_OPEN 1
%define SOCKET_BIND 2
%define SOCKET_CONNECT 3
%define SOCKET_LISTEN 4
%define SOCKET_ACCEPT 5

%define IPPROTO_TCP 6
%define SOCK_STREAM 1
%define PF_INET 2
%define AF_INET 2
