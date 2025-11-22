SHELL := /bin/bash
.PHONY: all docker clean del_container run wave verilate vrun sim

DOCKER_NAME := direct-cache
IMAGE_NAME := cache_project:latest

SRC_DIR := rtl
TB_DIR := tb
BUILD_DIR := work
SIM := $(BUILD_DIR)/sim.out
VCD := $(BUILD_DIR)/dump.vcd

SRCS := $(wildcard $(SRC_DIR)/*.v)

all: docker

docker:
	if [ $$(docker ps -a -q -f name=$(DOCKER_NAME)) ]; then \
		docker start -ai $(DOCKER_NAME); \
	else \
		docker build -t $(IMAGE_NAME) .; \
		docker run --name $(DOCKER_NAME) -it \
			-v $(PWD):/workspace \
			-w /workspace \
			$(IMAGE_NAME) /bin/bash; \
	fi

sim: $(SIM)

$(SIM): $(SRCS) $(TB_DIR)/ikarus_tb.v
	mkdir -p $(BUILD_DIR)
	iverilog -g2012 -o $(SIM) $(SRCS) $(TB_DIR)/ikarus_tb.v

run: sim
	vvp $(SIM)

wave:
	gtkwave $(VCD) &

clean:
	rm -rf $(BUILD_DIR)

del_container:
	docker rm -f $(DOCKER_NAME)
