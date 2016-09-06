#
# Makefile to build Internet Drafts from markdown using mmarc and
# relying on the docker image "paulej/rfctools"
#
# Fetched from https://raw.githubusercontent.com/paulej/rfctools/4dc6dac691df8d1e18728bac25bb833790ddda8a/example/Makefile
#

SRC  := $(wildcard draft-*.md)
TXT  := $(patsubst %.md,%.txt,$(SRC))
HTML  := $(patsubst %.md,%.html,$(SRC))

DOCKER ?= docker

TOOL_PREFIX ?= docker run --rm --user=`id -u`:`id -g` -v `pwd`:/rfc -v $(HOME)/.cache/xml2rfc:/var/cache/xml2rfc paulej/rfctools

MD2RFC ?= $(TOOL_PREFIX) md2rfc
XML2RFC ?= $(TOOL_PREFIX) xml2rfc
MMARK ?= $(TOOL_PREFIX) mmark


# Ensure the xml2rfc cache directory exists locally
IGNORE := $(shell mkdir -p $(HOME)/.cache/xml2rfc)

all: $(TXT) $(HTML)

clean:
	rm -f draft-*.txt draft-*.xml draft-*.html

%.xml: %.md
	$(MMARK) -xml2 -page $< $@

%.html: %.xml
	$(XML2RFC) --html $<

%.txt: %.xml
	$(XML2RFC) --text $<

draft-spinel-protocol-bis.xml: draft-spinel-protocol-bis.md spinel-commands.md spinel-data-packing.md spinel-example-sessions.md spinel-feature-host-buffer-offload.md spinel-feature-network-save.md spinel-frame-format.md spinel-framing.md spinel-prop-core.md spinel-prop-ipv6.md spinel-prop-mac.md spinel-prop-net.md spinel-prop-phy.md spinel-prop.md spinel-status-codes.md spinel-tech-thread.md spinel-test-vectors.md
