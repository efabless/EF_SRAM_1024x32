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

class sram_init_seq(sram_bus_base_seq):
    # use this sequence write or read from register by the bus interface
    # this sequence should be connected to the bus sequencer in the testbench
    # you should create as many sequences as you need not only this one
    def __init__(self, name="sram_bus_seq", mem_size=0x400):
        super().__init__(name, mem_size)

    async def body(self):
        await super().body()
        # Add the sequqnce here
        # you could use method send_req to send a write or read using the register name
        # example for writing register by value > 5
        # await self.send_req(is_write=True, reg="control", data_condition=lambda data: data > 5)
        # example for writing register by value == 5
        # await self.send_req(is_write=True, reg="control", data_value=5)
        # example for reading register from register
        # await self.send_req(is_write=False, reg="control")
        for address in range(0, self.mem_size * 4, 4):
            await self.write_to_mem(address, size=bus_item.WORD_ACCESS)
        await self.send_nop()


uvm_object_utils(sram_init_seq)
