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


  //----------------------------------------------------------------
  // Internal constant and parameter definitions.
  //----------------------------------------------------------------


  //----------------------------------------------------------------
  // Registers including update variables and write enable.
  //----------------------------------------------------------------
  reg [63 : 0] udp_ctr_reg;
  reg [63 : 0] udp_ctr_new;
  reg          udp_ctr_inc;
  reg          udp_ctr_we;

  reg [63 : 0] tcp_ctr_reg;
  reg [63 : 0] tcp_ctr_new;
  reg          tcp_ctr_inc;
  reg          tcp_ctr_we;

  reg [63 : 0] icmp_ctr_reg;
  reg [63 : 0] icmp_ctr_new;
  reg          icmp_ctr_inc;
  reg          icmp_ctr_we;

  reg [63 : 0] ipv4_ctr_reg;
  reg [63 : 0] ipv4_ctr_new;
  reg          ipv4_ctr_inc;
  reg          ipv4_ctr_we;

  reg [63 : 0] ipv6_ctr_reg;
  reg [63 : 0] ipv6_ctr_new;
  reg          ipv6_ctr_inc;
  reg          ipv6_ctr_we;


  //----------------------------------------------------------------
  // Wires.
  //----------------------------------------------------------------


  //----------------------------------------------------------------
  // Concurrent connectivity for ports etc.
  //----------------------------------------------------------------
  assign debug = 8'h00;


  //----------------------------------------------------------------
  // reg_update
  //
  // Update functionality for all registers in the core.
  // All registers are positive edge triggered with asynchronous
  // active low reset. All registers have write enable.
  //----------------------------------------------------------------
  always @ (posedge clk or negedge reset_n)
    begin: reg_update
      if (!reset_n)
        begin
          udp_ctr_reg  <= 64'h0000000000000000;
          tcp_ctr_reg  <= 64'h0000000000000000;
          icmp_ctr_reg <= 64'h0000000000000000;
          ipv4_ctr_reg <= 64'h0000000000000000;
          ipv6_ctr_reg <= 64'h0000000000000000;
        end
      else
        begin
          if (udp_ctr_we)
            begin
              udp_ctr_reg <= udp_ctr_new;
            end

          if (tcp_ctr_we)
            begin
              tcp_ctr_reg <= tcp_ctr_new;
            end

          if (icmp_ctr_we)
            begin
              icmp_ctr_reg <= icmp_ctr_new;
            end

          if (ipv4_ctr_we)
            begin
              ipv4_ctr_reg <= ipv4_ctr_new;
            end

          if (ipv6_ctr_we)
            begin
              ipv6_ctr_reg <= ipv6_ctr_new;
            end
        end
    end // reg_update


  //----------------------------------------------------------------
  // udp_ctr
  //----------------------------------------------------------------
  always @*
    begin : udp_ctr
      udp_ctr_new = 64'h0000000000000000;
      udp_ctr_we  = 0;

      if (udp_ctr_inc)
        begin
          udp_ctr_new = udp_ctr_reg + 1'b1;
        end
    end // udp_ctr


  //----------------------------------------------------------------
  // tcp_ctr
  //----------------------------------------------------------------
  always @*
    begin : tcp_ctr
      tcp_ctr_new = 64'h0000000000000000;
      tcp_ctr_we  = 0;

      if (tcp_ctr_inc)
        begin
          tcp_ctr_new = tcp_ctr_reg + 1'b1;
        end
    end // tcp_ctr


  //----------------------------------------------------------------
  // icmp_ctr
  //----------------------------------------------------------------
  always @*
    begin : icmp_ctr
      icmp_ctr_new = 64'h0000000000000000;
      icmp_ctr_we  = 0;

      if (icmp_ctr_inc)
        begin
          icmp_ctr_new = icmp_ctr_reg + 1'b1;
        end
    end // icmp_ctr


  //----------------------------------------------------------------
  // ipv4_ctr
  //----------------------------------------------------------------
  always @*
    begin : ipv4_ctr
      ipv4_ctr_new = 64'h0000000000000000;
      ipv4_ctr_we  = 0;

      if (ipv4_ctr_inc)
        begin
          ipv4_ctr_new = ipv4_ctr_reg + 1'b1;
        end
    end // ipv4_ctr


  //----------------------------------------------------------------
  // ipv6_ctr
  //----------------------------------------------------------------
  always @*
    begin : ipv6_ctr
      ipv6_ctr_new = 64'h0000000000000000;
      ipv6_ctr_we  = 0;

      if (ipv6_ctr_inc)
        begin
          ipv6_ctr_new = ipv6_ctr_reg + 1'b1;
        end
    end // ipv6_ctr


  //----------------------------------------------------------------
  // eth_parser
  //----------------------------------------------------------------
  always @*
    begin : eth_parser
      udp_ctr_inc  = 0;
      tcp_ctr_inc  = 0;
      icmp_ctr_inc = 0;
      ipv4_ctr_inc = 0;
      ipv6_ctr_inc = 0;
    end

endmodule //fpga_eth_filter

//======================================================================
// EOF fpga_eth_filter.v
//======================================================================
