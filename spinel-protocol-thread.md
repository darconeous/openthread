# Protocol: Thread

This section describes all of the properties and semantics required
for managing a thread NCP.

## PHY Properties
### PROP 32: PROP_PHY_ENABLED
* Type: Read-Write
* Packed-Encoding: `b`

Set to `1` if the PHY is enabled, set to `0` otherwise.
May be directly enabled to bypass higher-level packet processing
in order to implement things like packet sniffers.

### PROP 33: PROP_PHY_CHAN
* Type: Read-Write
* Packed-Encoding: `C`

Value is the current channel. Must be set to one of the
values contained in `PROP_PHY_CHAN_SUPPORTED`.

### PROP 34: PROP_PHY_CHAN_SUPPORTED
* Type: Read-Only
* Packed-Encoding: `A(C)`
* Unit: List of channels

Value is a list of channel values that are supported by the
hardware.

### PROP 35: PROP_PHY_FREQ
* Type: Read-Only
* Packed-Encoding: `L`
* Unit: Kilohertz

Value is the radio frequency (in kilohertz) of the
current channel.

### PROP 36: PROP_PHY_CCA_THRESHOLD
* Type: Read-Write
* Packed-Encoding: `c`
* Unit: dBm

Value is the CCA (clear-channel assessment) threshold. Set to
-128 to disable.

When setting, the value will be rounded down to a value
that is supported by the underlying radio hardware.

### PROP 37: PROP_PHY_TX_POWER
* Type: Read-Write
* Packed-Encoding: `c`
* Unit: dBm

Value is the transmit power of the radio.

When setting, the value will be rounded down to a value
that is supported by the underlying radio hardware.

### PROP 38: PROP_PHY_RSSI
* Type: Read-Only
* Packed-Encoding: `c`
* Unit: dBm

Value is the current RSSI (Received signal strength indication)
from the radio. This value can be used in energy scans and for
determining the ambient noise floor for the operating environment.


## MAC Properties


### PROP 48: PROP_MAC_SCAN_STATE
* Type: Read-Write
* Packed-Encoding: `C`
* Unit: Enumeration

Possible Values:

* 0: `SCAN_STATE_IDLE`
* 1: `SCAN_STATE_BEACON`
* 2: `SCAN_STATE_ENERGY`

Set to `SCAN_STATE_BEACON` to start an active scan.
Beacons will be emitted from `PROP_MAC_SCAN_BEACON`.

Set to `SCAN_STATE_ENERGY` to start an energy scan.
Channel energy will be reported by alternating emissions
of `PROP_PHY_CHAN` and `PROP_PHY_RSSI`.

Values switches to `SCAN_STATE_IDLE` when scan is complete.

### PROP 49: PROP_MAC_SCAN_MASK
* Type: Read-Write
* Packed-Encoding: `A(C)`
* Unit: List of channels to scan


### PROP 50: PROP_MAC_SCAN_PERIOD
* Type: Read-Write
* Packed-Encoding: `A(C)`
* Unit: List of channels to scan

### PROP 51: PROP_MAC_SCAN_BEACON
* Type: Read-Only-Stream
* Packed-Encoding: `CcDD.` (or `CcT(ESSc.)T(iCUD.).`)

Octets: |  1   |   1  |      2       |   *n*    |       2      |   *n*  
--------|------|------|--------------|----------|--------------|----------  
Fields: | CHAN | RSSI | MAC_DATA_LEN | MAC_DATA | NET_DATA_LEN | NET_DATA  

Scan beacons have two embedded structures which contain
information about the MAC layer and the NET layer. Their
format depends on the MAC and NET layer currently in use.
The format below is for an 802.15.4 MAC with Thread:

* `C`: Channel
* `c`: RSSI of the beacon
* `T`: MAC layer properties
  * `E`: Long address
  * `S`: Short address
  * `S`: PAN-ID
  * `c`: LQI
* `T`: NET layer properties
  * `i`: Protocol Number
  * `C`: Flags
  * `U`: Network Name
  * `D`: XPANID

Extra parameters may be added to each of the structures
in the future, so care should be taken to read the length
that prepends each structure.

### PROP 52: PROP_MAC_15_4_LADDR
* Type: Read-Write
* Packed-Encoding: `E`

The 802.15.4 long address of this node.

### PROP 53: PROP_MAC_15_4_SADDR
* Type: Read-Write
* Packed-Encoding: `S`

The 802.15.4 short address of this node.

### PROP 54: PROP_MAC_15_4_PANID
* Type: Read-Write
* Packed-Encoding: `S`

The 802.15.4 PANID this node is associated with.

### PROP 55: PROP_MAC_RAW_STREAM_ENABLED
* Type: Read-Write
* Packed-Encoding: `b`

Set to true to enable raw MAC frames to be emitted from `PROP_STREAM_RAW`.

### PROP 56: PROP_MAC_FILTER_MODE
* Type: Read-Write
* Packed-Encoding: `C`

Possible Values:

* 0: `MAC_FILTER_MODE_NORMAL`: Normal MAC filtering is in place.
* 1: `MAC_FILTER_MODE_PROMISCUOUS`: All MAC packets matching network are passed up the stack.
* 2: `MAC_FILTER_MODE_MONITOR`: All decoded MAC packets are passed up the stack.

### PROP 4864: PROP_MAC_WHITELIST
* Type: Read-Write
* Packed-Encoding: `A(T(Ec))`

Structure Parameters:

* `E`: EUI64 address of node
* `c`: Optional RSSI-override value. The value 127 indicates
       that the RSSI-override feature is not enabled for this
       address. If this value is ommitted when setting or
       inserting, it is assumed to be 127. This parameter is
       ignored when removing.

### PROP 4865: PROP_MAC_WHITELIST_ENABLED
* Type: Read-Write
* Packed-Encoding: `b`

## NET Properties

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



## THREAD Properties

### PROP 80: PROP_THREAD_LEADER_ADDR
* Type: Read-Only
* Packed-Encoding: `6`

The IPv6 address of the leader. (Note: May change to long and short address of leader)

### PROP 81: PROP_THREAD_PARENT
* Type: Read-Only
* Packed-Encoding: `ES`
* LADDR, SADDR

The long address and short address of the parent of this node.

### PROP 82: PROP_THREAD_CHILD_TABLE
* Type: Read-Only
* Packed-Encoding: `A(T(ES))`

Table containing the long and short addresses of all
the children of this node.

### PROP 83: PROP_THREAD_LEADER_RID
* Type: Read-Only
* Packed-Encoding: `C`

The router-id of the current leader.

### PROP 84: PROP_THREAD_LEADER_WEIGHT
* Type: Read-Only
* Packed-Encoding: `C`

The leader weight of the current leader.

### PROP 85: PROP_THREAD_LOCAL_LEADER_WEIGHT
* Type: Read-Write
* Packed-Encoding: `C`

The leader weight for this node.

### PROP 86: PROP_THREAD_NETWORK_DATA
* Type: Read-Only
* Packed-Encoding: `D`

### PROP 87: PROP_THREAD_NETWORK_DATA_VERSION
* Type: Read-Only
* Packed-Encoding: `S`

### PROP 88: PROP_THREAD_STABLE_NETWORK_DATA
* Type: Read-Only
* Packed-Encoding: `D`

### PROP 89: PROP_THREAD_STABLE_NETWORK_DATA_VERSION
* Type: Read-Only
* Packed-Encoding: `S`

### PROP 90: PROP_THREAD_ON_MESH_NETS
* Type: Read-Write
* Packed-Encoding: `A(T(6CbC))`

Data per item is:

* `6`: IPv6 Prefix
* `C`: Prefix length, in bits
* `b`: Stable flag
* `C`: Other flags

### PROP 91: PROP_THREAD_LOCAL_ROUTES
* Type: Read-Write
* Packed-Encoding: `A(T(6CbC))`

Data per item is:

* `6`: IPv6 Prefix
* `C`: Prefix length, in bits
* `b`: Stable flag
* `C`: Other flags

### PROP 92: PROP_THREAD_ASSISTING_PORTS
* Type: Read-Write
* Packed-Encoding: `A(S)`

### PROP 93: PROP_THREAD_ALLOW_LOCAL_NET_DATA_CHANGE
* Type: Read-Write
* Packed-Encoding: `b`

Set to true before changing local net data. Set to false when finished.
This allows changes to be aggregated into single events.

### PROP 94: PROP_THREAD_MODE
* Type: Read-Write
* Packed-Encoding: `C`

This property contains the value of the mode
TLV for this node. The meaning of the bits in this
bitfield are defined by section 4.5.2 of the Thread
specification.

### PROP 5376: PROP_THREAD_CHILD_TIMEOUT
* Type: Read-Write
* Packed-Encoding: `L`

Used when operating in the Child role.

### PROP 5377: PROP_THREAD_RLOC16
* Type: Read-Write
* Packed-Encoding: `S`

### PROP 5378: PROP_THREAD_ROUTER_UPGRADE_THRESHOLD
* Type: Read-Write
* Packed-Encoding: `C`

### PROP 5379: PROP_THREAD_CONTEXT_REUSE_DELAY
* Type: Read-Write
* Packed-Encoding: `L`

### PROP 5380: PROP_THREAD_NETWORK_ID_TIMEOUT
* Type: Read-Write
* Packed-Encoding: `C`

Allows you to get or set the Thread `NETWORK_ID_TIMEOUT` constant, as
defined by the Thread specification.

### PROP 5381: PROP_THREAD_ACTIVE_ROUTER_IDS
* Type: Read-Write/Write-Only
* Packed-Encoding: `A(C)` (List of active thread router ids)

Note that some implementations may not support `CMD_GET_VALUE`
routerids, but may support `CMD_REMOVE_VALUE` when the node is
a leader.

### PROP 5382: PROP_THREAD_RLOC16_DEBUG_PASSTHRU
* Type: Read-Write
* Packed-Encoding: `b`

Allow the HOST to directly observe all IPv6 packets received by the NCP,
including ones sent to the RLOC16 address.

Default value is `false`.

## IPv6 Properties

### PROP 96: PROP_IPV6_LL_ADDR
* Type: Read-Only
* Packed-Encoding: `6`

IPv6 Address

### PROP 97: PROP_IPV6_ML_ADDR
* Type: Read-Only
* Packed-Encoding: `6`

IPv6 Address + Prefix Length

### PROP 98: PROP_IPV6_ML_PREFIX
* Type: Read-Write
* Packed-Encoding: `6C`

IPv6 Prefix + Prefix Length

### PROP 99: PROP_IPV6_ADDRESS_TABLE
* Type: Read-Write
* Packed-Encoding: `A(T(6CLLC))`

Array of structures containing:

* `6`: IPv6 Address
* `C`: Network Prefix Length
* `L`: Valid Lifetime
* `L`: Preferred Lifetime
* `C`: Flags

### PROP 100: PROP_IPv6_ROUTE_TABLE
* Type: Read-Write
* Packed-Encoding: `A(T(6C6))`

Array of structures containing:

* `6`: IPv6 Prefix
* `C`: Network Prefix Length
* `C`: Interface ID
* `C`: Flags

### PROP 101: PROP_IPv6_ICMP_PING_OFFLOAD
* Type: Read-Write
* Packed-Encoding: `b`

Allow the NCP to directly respond to ICMP ping requests. If this is
turned on, ping request ICMP packets will not be passed to the host.

Default value is `false`.

