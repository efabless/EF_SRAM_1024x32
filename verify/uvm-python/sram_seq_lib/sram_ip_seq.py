from uvm.macros.uvm_object_defines import uvm_object_utils
from uvm.macros.uvm_sequence_defines import uvm_do_with, uvm_do
from uvm.base import sv, UVM_HIGH, UVM_LOW
from uvm.macros.uvm_message_defines import uvm_info, uvm_fatal
from sram_item.sram_item import sram_item
from uvm.seq import UVMSequence


class sram_ip_seq(UVMSequence):
    # use this sequence write or read from register by the ip interface
    # this sequence should be connected to the ip sequencer in the testbench
    # you should add as many sequences as you need not only this one
    def __init__(self, name="sram_ip_seq"):
        UVMSequence.__init__(self, name)
        self.set_automatic_phase_objection(1)
        self.req = sram_item()
        self.rsp = sram_item()
        self.tag = name

    async def body(self):
        # Add sequence to be used by the ip sequencer
        # you could use method uvm_do and uvm_do_with to send these transactions
        # send item with conditions
        # await uvm_do_with(self, self.req, lambda sram_var1: sram_var1 == 10, lambda sram_var2: sram_var2 > 7, ......)
        # send item without conditions
        # await uvm_do(self, self.req)
        pass


uvm_object_utils(sram_ip_seq)
