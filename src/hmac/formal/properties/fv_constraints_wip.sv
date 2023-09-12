module fv_constraints_wip_m
(
    input logic           clk,
    input logic           rst_n,
    input logic           hmac_init,
    input logic           hmac_next,
    input wire [383  : 0] key,
    input wire [1023 : 0] block_msg,
    input logic           sha1_init,
    input logic           sha1_next,
    input logic           sha2_init,
    input logic           sha2_next,
    input logic [2   : 0] ctrl_reg,
    input logic           first_round
);
        default clocking default_clk @(posedge clk); endclocking

/*     assume_wip_key_stable: assume property(disable iff(!rst_n)
       hmac_init
    |=>
      ($stable(key) || hmac_init)
    ); 
 */

    endmodule

    bind hmac_core fv_constraints_wip_m constraints_wip(
        .clk        (clk                      ),
        .rst_n      (reset_n && !zeroize      ),
        .hmac_init  (init_cmd                 ),
        .hmac_next  (next_cmd                 ),
        .sha1_init  (u_sha512_core_h1.init_cmd),
        .sha1_next  (u_sha512_core_h1.next_cmd),
        .sha2_init  (u_sha512_core_h2.init_cmd),
        .sha2_next  (u_sha512_core_h2.next_cmd),
        .ctrl_reg   (hmac_ctrl_new            ),
        .first_round(first_round              ),
        .key        (key                      ),
        .block_msg  (block_msg                )
    );