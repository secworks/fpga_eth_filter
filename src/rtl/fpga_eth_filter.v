//======================================================================
//
// fpga_eth_filter.v
// -----------------
// Experimental Ethernet filter core.
//
//
// Author: Joachim Strombergson
// Copyright (c) 2013, 2014, Secworks Sweden AB
// All rights reserved.
//
// Redistribution and use in source and binary forms, with or
// without modification, are permitted provided that the following
// conditions are met:
//
// 1. Redistributions of source code must retain the above copyright
//    notice, this list of conditions and the following disclaimer.
//
// 2. Redistributions in binary form must reproduce the above copyright
//    notice, this list of conditions and the following disclaimer in
//    the documentation and/or other materials provided with the
//    distribution.
//
// THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS
// "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT
// LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS
// FOR A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE
// COPYRIGHT OWNER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT,
// INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING,
// BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES;
// LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER
// CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT,
// STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE)
// ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF
// ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
//
//======================================================================

module fpga_eth_filter(
                       input wire          clk,
                       input wire          reset_n,

                       input wire          rxd,
                       output wire         txd,

                       output wire         eth0_clk,
                       input wire [7 : 0]  eth0_rxd,
                       input wire          eth0_rxdv,
                       input wire          eth0_rxer,
                       output wire [7 : 0] eth0_txd,
                       output wire         eth0_txen,

                       output wire         eth1_clk,
                       input wire [7 : 0]  eth1_rxd,
                       input wire          eth1_rxdv,
                       input wire          eth1_rxer,
                       output wire [7 : 0] eth1_txd,
                       output wire         eth1_txen,

                       output wire [7 : 0] debug
                      );


endmodule //fpga_eth_filter

//======================================================================
// EOF fpga_eth_filter.v
//======================================================================
