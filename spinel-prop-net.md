## NET Properties {#prop-net}

### PROP 64: PROP_NET_SAVED
* Type: Read-Only
* Packed-Encoding: `b`

Returns true if there is a network state stored that can be
restored with a call to `CMD_NET_RECALL`.

### PROP 65: PROP_NET_IF_UP
* Type: Read-Write
* Packed-Encoding: `b`

Network interface up/down status. Non-zero (set to 1) indicates up,
zero indicates down.

### PROP 66: PROP_NET_STACK_UP
* Type: Read-Write
* Packed-Encoding: `b`
* Unit: Enumeration

Thread stack operational status. Non-zero (set to 1) indicates up,
zero indicates down.

### PROP 67: PROP_NET_ROLE
* Type: Read-Write
* Packed-Encoding: `C`
* Unit: Enumeration

Values:

* 0: `NET_ROLE_DETACHED`
* 1: `NET_ROLE_CHILD`
* 2: `NET_ROLE_ROUTER`
* 3: `NET_ROLE_LEADER`

### PROP 68: PROP_NET_NETWORK_NAME
* Type: Read-Write
* Packed-Encoding: `U`

### PROP 69: PROP_NET_XPANID
* Type: Read-Write
* Packed-Encoding: `D`

### PROP 70: PROP_NET_MASTER_KEY
* Type: Read-Write
* Packed-Encoding: `D`

### PROP 71: PROP_NET_KEY_SEQUENCE
* Type: Read-Write
* Packed-Encoding: `L`

### PROP 72: PROP_NET_PARTITION_ID
* Type: Read-Write
* Packed-Encoding: `L`

The partition ID of the partition that this node is a member of.



