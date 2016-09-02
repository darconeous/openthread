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
device to communicate with and manage a network co-processor(NCP).

While initially designed to support Thread-based NCPs, the NCP protocol
has been designed with a layered approach that allows it to be easily
adapted to other network protocols.

.# Note

THIS DOCUMENT IS A WORK IN PROGRESS AND SUBJECT TO CHANGE.

Copyright (c) 2016 Nest Labs, All Rights Reserved

{mainmatter}

# Introduction ##

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

# Definitions ##

 *  **NCP**: Network Control Processor
 *  **Host**: Computer or Micro-controller which controls the NCP.
 *  **TID**: Transaction Identifier (0-15)
 *  **IID**: Interface Identifier (0-3)

{{spinel-frame-format.md}}

{{spinel-commands.md}}

{{spinel-general-properties.md}}

{{spinel-status-codes.md}}

{{spinel-data-packing.md}}

{backmatter}

{{spinel-framing.md}}

{{spinel-feature-network-save.md}}

{{spinel-feature-host-buffer-offload.md}}

{{spinel-protocol-thread.md}}

