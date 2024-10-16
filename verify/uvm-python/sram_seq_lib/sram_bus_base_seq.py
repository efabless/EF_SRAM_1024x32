from uvm.seq import UVMSequence
from uvm.macros.uvm_object_defines import uvm_object_utils
from uvm.macros.uvm_message_defines import uvm_fatal
from uvm.base.uvm_config_db import UVMConfigDb
from EF_UVM.bus_env.bus_seq_lib.bus_seq_base import bus_seq_base
from cocotb.triggers import Timer
from uvm.macros.uvm_sequence_defines import uvm_do_with, uvm_do
import random
from EF_UVM.bus_env.bus_item import bus_item


class sram_bus_base_seq(bus_seq_base):
    # use this sequence write or read from register by the bus interface
    # this sequence should be connected to the bus sequencer in the testbench
    # you should create as many sequences as you need not only this one
    def __init__(self, name="sram_bus_seq", mem_size=0x400):
        super().__init__(name)
        self.valid_addr = set()
        self.mem_size = mem_size

    async def body(self):
        await super().body()
    
    async def write_to_mem(self, address=None, data=None, size=None):
        self.create_new_item()
        self.req.rand_mode(0)
        if address is None:
            address = random.randint(0, self.mem_size - 1) << 2
        self.req.addr = address
        self.req.data = random.randint(0, 0xFFFFFFFF) if data is None else data
        self.req.kind = bus_item.WRITE
        self.req.size = bus_item.WORD_ACCESS if size is None else size
        await uvm_do(self, self.req)
        self.valid_addr.add(address)
        if self.req.size == bus_item.WORD_ACCESS:
            self.valid_addr.add(address + 1)
            self.valid_addr.add(address + 2)
            self.valid_addr.add(address + 3)
        elif self.req.size == bus_item.HALF_WORD_ACCESS:
            self.valid_addr.add(address + 1)

    async def read_from_mem(self, address=None, size=None):
        self.create_new_item()
        self.req.rand_mode(0)
        if address is None:
            address = random.randint(0, self.mem_size - 1) << 2
        self.req.addr = address
        self.req.data = 0
        self.req.kind = bus_item.READ
        self.req.size = bus_item.WORD_ACCESS if size is None else size
        await uvm_do(self, self.req)



uvm_object_utils(sram_bus_base_seq)
