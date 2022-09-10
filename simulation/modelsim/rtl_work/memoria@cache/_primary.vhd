library verilog;
use verilog.vl_types.all;
entity memoriaCache is
    port(
        clock           : in     vl_logic;
        wren            : in     vl_logic;
        data            : in     vl_logic_vector(2 downto 0);
        address         : in     vl_logic_vector(4 downto 0);
        hit             : out    vl_logic;
        valid           : out    vl_logic;
        LRU             : out    vl_logic;
        dirty           : out    vl_logic;
        writeBack       : out    vl_logic;
        tag             : out    vl_logic_vector(2 downto 0);
        dadoParaCPU     : out    vl_logic_vector(2 downto 0)
    );
end memoriaCache;
