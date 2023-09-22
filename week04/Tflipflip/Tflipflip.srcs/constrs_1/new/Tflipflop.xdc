set_property IOSTANDARD LVCMOS33 [get_ports Q]
set_property IOSTANDARD LVCMOS33 [get_ports T]
set_property IOSTANDARD LVCMOS33 [get_ports clk]
set_property IOSTANDARD LVCMOS33 [get_ports rst]
set_property PACKAGE_PIN L4 [get_ports Q]
set_property PACKAGE_PIN Y1 [get_ports T]
set_property CLOCK_DEDICATED_ROUTE FALSE [get_nets clk_IBUF]
set_property CLOCK_DEDICATED_ROUTE FALSE [get_nets rst_IBUF]


set_property DRIVE 12 [get_ports Q]

set_property OFFCHIP_TERM NONE [get_ports Q]
