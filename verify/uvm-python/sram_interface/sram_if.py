from uvm.base.sv import sv_if


class sram_if(sv_if):
    def __init__(self, dut):
        return
        # TODO: Add signal need to be seen by the ip monitor and driver in the following format
        # bus_map = {<signal name seen in testbench>: <signal name seen in dut>}
        # bus_map = {"reset": "rst", ...... }
        super().__init__(dut, "", bus_map)
