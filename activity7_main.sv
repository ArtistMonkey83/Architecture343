module FSM (input logic clk, Reset, left, right , hazard, brake
  output logic LA, LB, LC, RA, RB, RC);

  logic [7:0] state;
  logic [7:0] nextstate;

always_ff@ (posedge clk, posedge Reset){            //implementing flipflop memory
  if (Reset) state <= 0;
  else state <= nextstate;
}

always_comb begin                                    //Checking for the nextstate
  case(state)
//state 0 RESET State
  8'b00000001: begin
   if(left == 1){nextstate = 8'b00000010;}           //check if left is high, if it is go left
   else if(right == 1) {nextstate = 8'b00010000;}    //check if right is high, if it is go right
   else if(Reset == 1) {nextstate = 8'b00000001;}    //check if Reset is high, if it is go to state 0
   else if(hazard == 1) {nextstate = 8'b10000000;}   //check if hazard is high, if it is go to state 7, and then state 0
   else if(brake == 1) {nextstate = 8'b10000000;}    //check if brake is high, if it is go to state 7
  end
//state 1 LA is on
  8'b00000010: begin
  if(left == 1) {nextstate = 8'b00000100;}          //check if left is high, if it is go left
  else {nextstate = 8'b00000001;}                   //anyother combinations go to reset state 0
 end
//state 2 LA,LB is on
  8'b00000100: begin
  if(left == 1) {nextstate = 8'b00001000;}          //check if left is high, if it is go left
  else {nextstate = 8'b00000001;}                   //anyother combinations go to reset state 0
  end
//state 3 LA,LB,LC is on
  8'b00001000: begin
  if(left == 1) {nextstate = 8'b00000001;}          //check if left is high, if it is go to reset state 0
  else {nextstate = 8'b00000001;}                   //anyother combinations go to reset state 0
  end
//state 4 RA is on
  8'b00010000: begin
  if(right == 1) {nextstate = 8'b00000001;}          //check if right is high, if it is go to reset state 0
  else {nextstate = 8'b00000001;}                   //anyother combinations go to reset state 0
  end
//state 5 RA, RB is on
  8'b00100000: begin
  if(right == 1) {nextstate = 8'b00000001;}          //check if right is high, if it is go to reset state 0
  else {nextstate = 8'b00000001;}                   //anyother combinations go to reset state 0
  end
//state 6 RA, RB, RC is on
  8'b01000000: begin
  if(right == 1) {nextstate = 8'b00000001;}          //check if right is high, if it is go to reset state 0
  else {nextstate = 8'b00000001;}                   //anyother combinations go to reset state 0
  end
//state 7 ALL lights are on
  8'b10000000: begin
  if(right == 1) {nextstate = 8'b00000001;}          //check if right is high, if it is go to reset state 0
  else {nextstate = 8'b00000001;}                   //anyother combinations go to reset state 0
  end
endcase

always_comb begin                                   //implementing output logic
  case(state)
  //state 0 RESET State
    8'b00000001: {LA,LB,LC,RA,RB,RC} = 6'B000000;
  //state 1 LA is on
    8'b00000010: {LA,LB,LC,RA,RB,RC} = 6'B100000;
  //state 2 LA,LB is on
    8'b00000100: {LA,LB,LC,RA,RB,RC} = 6'B110000;
  //state 3 LA,LB,LC is on
    8'b00001000: {LA,LB,LC,RA,RB,RC} = 6'B111000;
  //state 4 RA is on
    8'b00010000: {LA,LB,LC,RA,RB,RC} = 6'B000100;
  //state 5 RA, RB is on
    8'b00100000: {LA,LB,LC,RA,RB,RC} = 6'B000110;
  //state 6 RA, RB, RC is on
    8'b01000000: {LA,LB,LC,RA,RB,RC} = 6'B000111;
  //state 7 ALL lights are on
    8'b10000000: {LA,LB,LC,RA,RB,RC} = 6'B111111;
  endcase
end
end module
