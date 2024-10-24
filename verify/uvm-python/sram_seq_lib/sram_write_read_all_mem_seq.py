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

class sram_write_read_all_mem_seq(sram_bus_base_seq):
    # use this sequence write or read from register by the bus interface
    # this sequence should be connected to the bus sequencer in the testbench
    # you should create as many sequences as you need not only this one
    def __init__(self, name="sram_corners_seq", mem_size=0x400):
        super().__init__(name, mem_size)
        self.mem_size = mem_size

    async def body(self):
        await super().body()
        all_addresses = [i * 4 for i in range(self.mem_size)]
        # test all is accessable        
        for address in all_addresses:
            await self.write_to_mem(address=address, data=address)
        for address in all_addresses:
            await self.read_from_mem(address=address, size=bus_item.WORD_ACCESS)
        # write 0 to all 
        for address in all_addresses:
            await self.write_to_mem(address=address, data=0)
        # read from all
        for address in all_addresses:
            await self.read_from_mem(address=address, size=bus_item.WORD_ACCESS)
        # write 1 to all bits 
        for address in all_addresses:
            await self.write_to_mem(address=address, data=0xFFFFFFFF)
        # read from all
        for address in all_addresses:
            await self.read_from_mem(address=address, size=bus_item.WORD_ACCESS)
        # write 01 to all
        for address in all_addresses:
            await self.write_to_mem(address=address, data=0x55555555)
        # read from all
        for address in all_addresses:
            await self.read_from_mem(address=address, size=bus_item.WORD_ACCESS)
        # write 10 to all
        for address in all_addresses:
            await self.write_to_mem(address=address, data=0xaaaaaaaa)
        # read from all
        for address in all_addresses:
            await self.read_from_mem(address=address, size=bus_item.WORD_ACCESS)        
        for i in range(10):
            await self.send_nop()

    async def _write_read_seq(self, iterations, write_priority):
        for _ in range(iterations):
            address, size = self.rand_addr_size()
            if random.random() >= write_priority:
                await self.write_to_mem(address=address, size=size)
            else:
                await self.read_from_mem(address=address, size=size)


uvm_object_utils(sram_write_read_all_mem_seq)
