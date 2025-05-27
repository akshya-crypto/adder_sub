
module adder_sub(input [3:0]a,b1,
                 input sub,
                 output [3:0]out,
                 output cout);
  wire [3:0] b;
  wire [3:0] c;
  assign b = b1 ^ {4{sub}};
  
  full_adder inst1(.a(a[0]),.b(b[0]),.cin(sub),.sum(out[0]),.cout(c[0]));
  full_adder inst2(.a(a[1]),.b(b[1]),.cin(c[0]),.sum(out[1]),.cout(c[1]));
  full_adder inst3(.a(a[2]),.b(b[2]),.cin(c[1]),.sum(out[2]),.cout(c[2]));
  full_adder inst4(.a(a[3]),.b(b[3]),.cin(c[2]),.sum(out[3]),.cout(c[3]));
  
  assign cout=c[3];
                   
endmodule

module full_adder(input a,b,cin,
                  output sum,cout);
  assign sum= a^b^cin;
  assign cout= (a&b)|(a&cin)|(b&cin);
endmodule


module testadder_sub;
  reg a_tb;
  reg b_tb;
  reg cin_tb;
  wire sum_tb,cout_tb;
  
  full_adder uut(.a(a_tb),.b(b_tb),.cin(cin_tb),.sum(sum_tb),.cout(cout_tb));
  
  initial
    begin
      $monitor($time,"a=%b,b=%b,cin=%b,sum=%b,cout=%b",a_tb,b_tb,cin_tb,sum_tb,cout_tb);
      #5 a_tb=0; b_tb=0; cin_tb=0;
      #5 a_tb=0; b_tb=0; cin_tb=1;
      #5 a_tb=0; b_tb=1; cin_tb=0;
      #5 a_tb=0; b_tb=1; cin_tb=1;
      #5 a_tb=1; b_tb=0; cin_tb=0;
      #5 a_tb=1; b_tb=0; cin_tb=1;
      #5 a_tb=1; b_tb=1; cin_tb=0;
      #5 a_tb=1; b_tb=1; cin_tb=1;
      #5 $finish;
    end
endmodule

module test_adder_sub;
  reg [3:0]a_tb;
  reg [3:0]b_tb;
  reg sub_tb;
  
  wire [3:0]out_tb;
  wire cout_tb;
  
  adder_sub uut(.a(a_tb),.b1(b_tb),.out(out_tb),.sub(sub_tb),.cout(cout_tb));
  initial
    begin
      $monitor($time,"a=%b,b=%b,sub=%b,out=%b,cout=%b",a_tb,b_tb,sub_tb,out_tb,cout_tb);
      
      #5 a_tb=4'b0001; b_tb=4'b0010; sub_tb=1'b0;
      #5 a_tb=4'b0011; b_tb=4'b0100; sub_tb=1'b0;
      #5 a_tb=4'b1111; b_tb=4'b0001; sub_tb=1'b0;
      
      #5 a_tb=4'b0101; b_tb=4'b0010; sub_tb=1'b1;
      #5 a_tb=4'b0110; b_tb=4'b0110; sub_tb=1'b1;
      #5 a_tb=4'b0001; b_tb=4'b0010; sub_tb=1'b1;
      #5 $finish;
    end
endmodule
      
  
  

  

                 