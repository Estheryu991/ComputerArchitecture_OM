`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Engineer: Elias von Däniken, Adrian Tonica, Gian Schaller
// Create Date: 03/24/2022 01:01:56 PM
// Design Name: decoder Lab report 2
//////////////////////////////////////////////////////////////////////////////////


module decoder(input a, input b, output [3:0] s);
    wire notA, notB;

    not input_notA(notA, a);
    not input_notB(notB, b);
    
    and a1(s[0], notA, notB);
    and a2(s[1], a, notB);
    and a3(s[2], notA, b);
    and a4(s[3], a, b);
endmodule

------------------------

set_property PACKAGE_PIN V17 [get_ports {a}]
set_property PACKAGE_PIN V16 [get_ports {b}]
set_property PACKAGE_PIN U16 [get_ports {s[0]}]
set_property PACKAGE_PIN E19 [get_ports {s[1]}]
set_property PACKAGE_PIN U19 [get_ports {s[2]}]
set_property PACKAGE_PIN V19 [get_ports {s[3]}]
set_property IOSTANDARD LVCMOS33 [get_ports {a b s}]

-------------------------

`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Engineer: Elias von Däniken, Adrian Tonica, Gian Schaller
// Create Date: 03/24/2022 01:01:56 PM
// Design Name: multiplexer 2 to 1 Lab2 report
//////////////////////////////////////////////////////////////////////////////////


module mul2to1(input a, input b, input s, output d);
    wire notS, d0, d2;

    not i(notS, s);
    
    and a1(d0, a, notS);
    and a2(d1, b, s);
    or o1(d, d0, d1);
endmodule

-----------------------

`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Engineer: Elias von Däniken, Adrian Tonica, Gian Schaller
// Create Date: 03/24/2022 01:01:56 PM
// Design Name: multiplexer 4 to 1 Lab 2 report
//////////////////////////////////////////////////////////////////////////////////


module mul4to1(input a, input b, input c, input d, input [1:0] s, output D);
    wire mul1_out, mul2_out;
    mul2to1 mul1(.a(a), .b(b), .s(s[1]), .d(mul1_out));
    mul2to1 mul2(.a(c), .b(d), .s(s[1]), .d(mul2_out));
    mul2to1 mul3(.a(mul1_out), .b(mul2_out), .s(s[0]), .d(D));
endmodule

----------------------

set_property PACKAGE_PIN V17 [get_ports {a}]
set_property PACKAGE_PIN V16 [get_ports {b}]
set_property PACKAGE_PIN W16 [get_ports {c}]
set_property PACKAGE_PIN W17 [get_ports {d}]
set_property PACKAGE_PIN W15 [get_ports {s[0]}]
set_property PACKAGE_PIN V15 [get_ports {s[1]}]
set_property PACKAGE_PIN U16 [get_ports {D}]
set_property IOSTANDARD LVCMOS33 [get_ports {a b c d s D}]
