%%%
	title = "Spinel Host-Controller Protocol"
   	abbrev = "spinel-protocol"
	category = "std"
	docName = "draft-spinel-protocol-bis"
	ipr = "none"
	keyword = ["Spinel", "OpenThread", "Thread", "NCP"]

	date = 2016-09-02T00:00:00Z

    [pi]
    editing = "yes"
    private = "OpenThread"
    compact = "no"
    subcompact = "yes"
    comments = "yes"

	[[author]]
	initials = "R."
	surname = "Quattlebaum"
	fullname = "Robert S. Quattlebaum"
	role = "editor"
	organization = "Nest Labs"
	  [author.address]
	  email = "rquattle@nestlabs.com"
	  [author.address.postal]
	  street = "3400 Hillview Ave."
	  city = "Palo Alto"
	  region = "California"
	  code = "94304"
	  country = "USA"
%%%

.# Abstract

This document describes a general management protocol for enabling a host
device to communicate with and manage a network control processor (NCP).

While initially designed to support Thread-based NCPs, the NCP protocol
has been designed with a layered approach that allows it to be easily
adapted to other network technologies in the future.

.# Status of This Document

This document is a work in progress and subject to change.

.# Copyright Notice

Copyright (c) 2016 Nest Labs, All Rights Reserved

{mainmatter}

# Introduction #

This Network Control Processor (NCP) protocol was designed to enable a host
device to communicate with and manage a NCP while also achieving the
following goals:

 *  Adopt a layered approach to the protocol design, allowing future
    support for other network protocols.
 *  Minimize the number of required commands/methods by providing a
    rich, property-based API.
 *  Support NCPs capable of being connected to more than one network
    at a time.
 *  Gracefully handle the addition of new features and capabilities
    without necessarily breaking backward compatibility.
 *  Be as minimal and light-weight as possible without unnecessarily
    sacrificing flexibility.

On top of this core framework, we define the properties and commands
to enable various features and network protocols.

# Definitions #

NCP
: Acryonym for Network Control Processor.

Host
: Computer or Micro-controller which controls the NCP.

TID
: Transaction Identifier. May be a value between zero and fifteen.
  See (#tid-transaction-identifier) for more information.

IID
: Interface Identifier. May be a value between zero and three.
  See (#iid-interface-identifier) for more information.

PUI
: Packed Unsigned Integer. A way to serialize an unsigned integer
  using one, two, or three bytes. Used throughout the Spinel protocol.
  See (#packed-unsigned-integer) for more information.

{{spinel-frame-format.md}}

{{spinel-data-packing.md}}

{{spinel-commands.md}}

{{spinel-prop.md}}

{{spinel-status-codes.md}}

{backmatter}

{{spinel-framing.md}}

{{spinel-feature-network-save.md}}

{{spinel-feature-host-buffer-offload.md}}

{{spinel-tech-thread.md}}

{{spinel-test-vectors.md}}

{{spinel-example-sessions.md}}
