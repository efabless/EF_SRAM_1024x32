from uvm.seq import UVMSequence
from uvm.macros.uvm_object_defines import uvm_object_utils
from uvm.macros.uvm_message_defines import uvm_fatal
from uvm.base.uvm_config_db import UVMConfigDb
from EF_UVM.bus_env.bus_seq_lib.bus_seq_base import bus_seq_base
from cocotb.triggers import Timer
from uvm.macros.uvm_sequence_defines import uvm_do_with, uvm_do
import random
from EF_UVM.bus_env.bus_item import bus_item
from sram_seq_lib.sram_bus_base_seq import sram_bus_base_seq
from sram_seq_lib.sram_init_seq import sram_init_seq
import cocotb

class sram_write_read_seq(sram_bus_base_seq):
    # use this sequence write or read from register by the bus interface
    # this sequence should be connected to the bus sequencer in the testbench
    # you should create as many sequences as you need not only this one
    def __init__(self, name="sram_corners_seq", mem_size=0x400):
        super().__init__(name, mem_size)

    async def body(self):
        await super().body()
        await self.write_to_mem(address=0)
        await self.write_to_mem(address=0x4)
        await self.write_to_mem(address=0x8)
        await self.read_from_mem(address=0)
        await self.read_from_mem(address=0x4)
        await self.read_from_mem(address=0x8)
        await uvm_do_with(self, sram_init_seq("sram_init_seq", self.mem_size))
        await self._write_read_seq(self.mem_size * 2, 0.5)
    
    async def _write_read_seq(self, iterations, write_priority):
        for _ in range(iterations):
            address, size = self.rand_addr_size()
            if random.random() >= write_priority:
                await self.write_to_mem(address=address, size=size)
            else:
                await self.read_from_mem(address=address, size=size)

    def rand_addr_size(self):
        BUS_TYPE = cocotb.plusargs["BUS_TYPE"]
        if BUS_TYPE == "AHB":
            address = random.randint(0, (self.mem_size - 1) * 4)
            if address % 4 == 0:
                size = random.choice((bus_item.WORD_ACCESS, bus_item.HALF_WORD_ACCESS, bus_item.BYTE_ACCESS))
            elif address % 2 == 0:
                size = random.choice((bus_item.HALF_WORD_ACCESS, bus_item.BYTE_ACCESS))
            else:
                size = bus_item.BYTE_ACCESS
        else: # sizes are fixed for APB and WB
            address = random.randint(0, self.mem_size - 1) << 2
            size = bus_item.WORD_ACCESS
            
        return address, size

uvm_object_utils(sram_write_read_seq)
