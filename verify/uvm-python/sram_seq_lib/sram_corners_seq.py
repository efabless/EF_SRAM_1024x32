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

class sram_corners_seq(sram_bus_base_seq):
    # use this sequence write or read from register by the bus interface
    # this sequence should be connected to the bus sequencer in the testbench
    # you should create as many sequences as you need not only this one
    def __init__(self, name="sram_corners_seq", mem_size=0x400):
        super().__init__(name, mem_size)

    async def body(self):
        await super().body()
        await uvm_do_with(self, sram_init_seq("sram_init_seq", self.mem_size))
        await uvm_do_with(self, sram_same_address_seq("sram_same_address_seq", self.mem_size))
        await uvm_do_with(self, sram_one_zeros_seq("sram_one_zeros_seq", self.mem_size))
        await uvm_do_with(self, sram_lowest_highest_seq("sram_lowest_highest_seq", self.mem_size))


uvm_object_utils(sram_corners_seq)


class sram_same_address_seq(sram_bus_base_seq):
    def __init__(self, name="sram_same_address_seq", mem_size=0x400):
        super().__init__(name, mem_size)

    async def body(self):
        await super().body()
        for __ in range(10):
            pick_address = random.randint(0, self.mem_size - 1) << 2
            # randomly read and write to the same address 20 times
            for _ in range(25):
                if random.random() >= 0.5:
                    await self.write_to_mem(address=pick_address)
                else:
                    await self.read_from_mem(address=pick_address)


uvm_object_utils(sram_same_address_seq)


class sram_one_zeros_seq(sram_bus_base_seq):
    def __init__(self, name="sram_one_zeros_seq", mem_size=0x400):
        super().__init__(name, mem_size)

    async def body(self):
        await super().body()

        for _ in range(self.mem_size):
            data = random.choice(
                (0x0, 0xAAAAAAAA, 0x55555555, 0xFFFFFFFF, 0x33333333, 0xCCCCCCCC)
            )
            await self.write_to_mem(data=data)

        for _ in range(self.mem_size):
            await self.read_from_mem()


uvm_object_utils(sram_same_address_seq)


class sram_lowest_highest_seq(sram_bus_base_seq):
    def __init__(self, name="sram_one_zeros_seq", mem_size=0x400):
        super().__init__(name, mem_size)

    async def body(self):
        await super().body()
        # initialize with 0
        for _ in range(self.mem_size):
            await self.write_to_mem(data=0)

        # write then read small data
        for _ in range(self.mem_size):
            await self.write_to_mem(data=random.getrandbits(5))

        for _ in range(self.mem_size):
            await self.read_from_mem()

        # initialize with 0
        for _ in range(self.mem_size):
            await self.write_to_mem(data=0)

        # write then read large data
        for _ in range(self.mem_size):
            await self.write_to_mem(data=random.randint(2**25, 2**32 - 1))

        for _ in range(self.mem_size):
            await self.read_from_mem()

uvm_object_utils(sram_lowest_highest_seq)
