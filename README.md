# Misc. Erlang  Utilities

Found I could use various functionality over several projects. Collected them into this hodge-podge of modules. Will update as functionality added.

### Modules
 - Base32: Provide base-32 encoding / decoding functionality.
 
   API:
    - encode/1: Binary to encode. Provides only uppercase outputs.
    - decode/1: Binary to decode. Case-insensitive.
    
    Reference: [The Base16, Base32, and Base64 Data Encodings](https://tools.ietf.org/html/rfc4648#section-6)
    
 - IFace: Utility to get MAC and IP information from NICs.
 
   API:
    - to_binary/1: Convert IPv4, IPv6 or MAC address to binary string.
    - enum/0: Outputs the number of NICs and a list of their identifiers
    - get_ipv4/0: IPv4 address of first non-loopback NIC.
    - get_ipv4/1: IPv4 address of specified NIC.
    - get_ipv6/0: IPv6 address of first non-loopback NIC.
    - get_ipv6/1: IPv6 address of specified NIC.
    - get_mac/0: Hardware address of first non-loopback NIC with an IP.
    - get_mac/1: Hardware address of specified NIC.
    
 - MathX: Set of extensions to math library.
 
   API:
    - is_odd/1: Tests oddity of integer.
    - is_even/1: Tests even-ness of integer.
    - mean/1: Computes the mean of all list elements.
    - median/1: Returns the median of the samples.
    - variance/1: Returns the sample variance and mean as a tuple.
    - stddev/1: Returns the sample standard deviation and mean as a tuple.
    - cull/2: Returns an order-preserved list where n•σ values are dropped.
