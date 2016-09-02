# Commands

* CMD 0: (Host->NCP) `CMD_NOOP`
* CMD 1: (Host->NCP) `CMD_RESET`
* CMD 2: (Host->NCP) `CMD_PROP_VALUE_GET`
* CMD 3: (Host->NCP) `CMD_PROP_VALUE_SET`
* CMD 4: (Host->NCP) `CMD_PROP_VALUE_INSERT`
* CMD 5: (Host->NCP) `CMD_PROP_VALUE_REMOVE`
* CMD 6: (NCP->Host) `CMD_PROP_VALUE_IS`
* CMD 7: (NCP->Host) `CMD_PROP_VALUE_INSERTED`
* CMD 8: (NCP->Host) `CMD_PROP_VALUE_REMOVED`
* CMD 9: (Host->NCP) `CMD_NET_SAVE` (See section B.1.1.)
* CMD 10: (Host->NCP) `CMD_NET_CLEAR`  (See section B.1.2.)
* CMD 11: (Host->NCP) `CMD_NET_RECALL`  (See section B.1.3.)
* CMD 12: (NCP->Host) `CMD_HBO_OFFLOAD` (See section C.1.1.)
* CMD 13: (NCP->Host) `CMD_HBO_RECLAIM` (See section C.1.2.)
* CMD 14: (NCP->Host) `CMD_HBO_DROP` (See section C.1.3.)
* CMD 15: (Host->NCP) `CMD_HBO_OFFLOADED` (See section C.1.4.)
* CMD 16: (Host->NCP) `CMD_HBO_RECLAIMED` (See section C.1.5.)
* CMD 17: (Host->NCP) `CMD_HBO_DROPPED` (See section C.1.6.)

## CMD 0: (Host->NCP) CMD_NOOP

Octets: |    1   |     1
--------|--------|----------
Fields: | HEADER | CMD_NOOP

No-Operation command. Induces the NCP to send a success status back to
the host. This is primarily used for liveliness checks.

The command payload for this command SHOULD be empty. The receiver
MUST ignore any non-empty command payload.

There is no error condition for this command.



## CMD 1: (Host->NCP) CMD_RESET

Octets: |    1   |     1
--------|--------|----------
Fields: | HEADER | CMD_RESET

Reset NCP command. Causes the NCP to perform a software reset. Due to
the nature of this command, the TID is ignored. The host should
instead wait for a `CMD_PROP_VALUE_IS` command from the NCP indicating
`PROP_LAST_STATUS` has been set to `STATUS_RESET_SOFTWARE`.

The command payload for this command SHOULD be empty. The receiver
MUST ignore any non-empty command payload.

If an error occurs, the value of `PROP_LAST_STATUS` will be emitted
instead with the value set to the generated status code for the error.



## CMD 2: (Host->NCP) CMD_PROP_VALUE_GET

Octets: |    1   |          1         |   1-3
--------|--------|--------------------|---------
Fields: | HEADER | CMD_PROP_VALUE_GET | PROP_ID

Get property value command. Causes the NCP to emit a
`CMD_PROP_VALUE_IS` command for the given property identifier.

The payload for this command is the property identifier encoded in the
packed unsigned integer format described in (#packed-unsigned-integer).

If an error occurs, the value of `PROP_LAST_STATUS` will be emitted
instead with the value set to the generated status code for the error.



## CMD 3: (Host->NCP) CMD_PROP_VALUE_SET

Octets: |    1   |          1         |   1-3   |    *n*
--------|--------|--------------------|---------|------------
Fields: | HEADER | CMD_PROP_VALUE_SET | PROP_ID | PROP_VALUE

Set property value command. Instructs the NCP to set the given
property to the specific given value, replacing any previous value.

The payload for this command is the property identifier encoded in the
packed unsigned integer format described in (#packed-unsigned-integer), followed by
the property value. The exact format of the property value is defined
by the property.

If an error occurs, the value of `PROP_LAST_STATUS` will be emitted
with the value set to the generated status code for the error.



## CMD 4: (Host->NCP) CMD_PROP_VALUE_INSERT

Octets: |    1   |          1            |   1-3   |    *n*
--------|--------|-----------------------|---------|------------
Fields: | HEADER | CMD_PROP_VALUE_INSERT | PROP_ID | VALUE_TO_INSERT

Insert value into property command. Instructs the NCP to insert the
given value into a list-oriented property, without removing other
items in the list. The resulting order of items in the list is defined
by the individual property being operated on.

The payload for this command is the property identifier encoded in the
packed unsigned integer format described in (#packed-unsigned-integer), followed by
the value to be inserted. The exact format of the value is defined by
the property.

If an error occurs, the value of `PROP_LAST_STATUS` will be emitted
with the value set to the generated status code for the error.



## CMD 5: (Host->NCP) CMD_PROP_VALUE_REMOVE

Octets: |    1   |          1            |   1-3   |    *n*
--------|--------|-----------------------|---------|------------
Fields: | HEADER | CMD_PROP_VALUE_REMOVE | PROP_ID | VALUE_TO_REMOVE

Remove value from property command. Instructs the NCP to remove the
given value from a list-oriented property, without affecting other
items in the list. The resulting order of items in the list is defined
by the individual property being operated on.

Note that this command operates *by value*, not by index!

The payload for this command is the property identifier encoded in the
packed unsigned integer format described in (#packed-unsigned-integer), followed by
the value to be removed. The exact format of the value is defined by
the property.

If an error occurs, the value of `PROP_LAST_STATUS` will be emitted
with the value set to the generated status code for the error.


## CMD 6: (NCP->Host) CMD_PROP_VALUE_IS

Octets: |    1   |          1        |   1-3   |    *n*
--------|--------|-------------------|---------|------------
Fields: | HEADER | CMD_PROP_VALUE_IS | PROP_ID | PROP_VALUE

Property value notification command. This command can be sent by the
NCP in response to a previous command from the host, or it can be sent
by the NCP in an unsolicited fashion to notify the host of various
state changes asynchronously.

The payload for this command is the property identifier encoded in the
packed unsigned integer format described in (#packed-unsigned-integer), followed by
the current value of the given property.



## CMD 7: (NCP->Host) CMD_PROP_VALUE_INSERTED

Octets: |    1   |            1            |   1-3   |    *n*
--------|--------|-------------------------|---------|------------
Fields: | HEADER | CMD_PROP_VALUE_INSERTED | PROP_ID | PROP_VALUE

Property value insertion notification command. This command can be
sent by the NCP in response to the `CMD_PROP_VALUE_INSERT` command, or
it can be sent by the NCP in an unsolicited fashion to notify the host
of various state changes asynchronously.

The payload for this command is the property identifier encoded in the
packed unsigned integer format described in (#packed-unsigned-integer), followed by
the value that was inserted into the given property.

The resulting order of items in the list is defined by the given
property.

## CMD 8: (NCP->Host) CMD_PROP_VALUE_REMOVED

Octets: |    1   |            1           |   1-3   |    *n*
--------|--------|------------------------|---------|------------
Fields: | HEADER | CMD_PROP_VALUE_REMOVED | PROP_ID | PROP_VALUE

Property value removal notification command. This command can be sent
by the NCP in response to the `CMD_PROP_VALUE_REMOVE` command, or it
can be sent by the NCP in an unsolicited fashion to notify the host of
various state changes asynchronously.

Note that this command operates *by value*, not by index!

The payload for this command is the property identifier encoded in the
packed unsigned integer format described in (#packed-unsigned-integer), followed by
the value that was removed from the given property.

The resulting order of items in the list is defined by the given
property.



