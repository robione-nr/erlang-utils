-module(base32).
-author("Nolan Robidoux").
-timestamp("2020/05/18 09:38 UTC").

-export([encode/1, decode/1]).

%% ====================================================================
%% API functions
%% ====================================================================


encode(Bin) when is_binary(Bin) ->
    ByteOffset = 5 * (byte_size(Bin) div 5),
    <<Body:ByteOffset/binary, Tail/binary>> = Bin,
    
    BitOffset = 5 * (bit_size(Tail) div 5),
    <<TailBody:BitOffset/bits, Rest/bits>> = Tail,
    TB1 = << <<(b32_enc(I))>> || <<I:5>> <= TailBody>>,
    
    {TB2, PadSz} = case Rest of
        <<I:3>> -> {<<(b32_enc(I bsl 2))>>, 6};
        <<I:1>> -> {<<(b32_enc(I bsl 4))>>, 4};
        <<I:4>> -> {<<(b32_enc(I bsl 1))>>, 3};
        <<I:2>> -> {<<(b32_enc(I bsl 3))>>, 1};
        <<>> -> {<<>>, 0}
    end,
    
    <<    (<< <<(b32_enc(I))>> || <<I:5>> <= Body>>)/binary,
        (<<TB1/binary, TB2/binary>>)/binary,
        (list_to_binary(lists:duplicate(PadSz, $=)))/binary        >>;
encode(_) ->
    {error, badarg}.


decode(Bin) when is_binary(Bin) ->
    decode(Bin, <<>>);
decode(_) ->
    {error, badarg}.

%% ====================================================================
%% Internal functions
%% ====================================================================

b32_enc(I) when I >= 26 andalso I =< 31 -> I + 24;
b32_enc(I) when I >= 0 andalso I =< 25 -> I + $A.


decode(<<X, "======">>, Bits) ->
    <<Bits/bits, (b32_dec(X) bsr 2):3>>;
decode(<<X, "====">>, Bits) ->
    <<Bits/bits, (b32_dec(X) bsr 4):1>>;
decode(<<X, "===">>, Bits) ->
    <<Bits/bits, (b32_dec(X) bsr 1):4>>;
decode(<<X, "=">>, Bits) ->
    <<Bits/bits, (b32_dec(X) bsr 3):2>>;
decode(<<X, Rest/binary>>, Bits) ->
    decode(Rest, <<Bits/bits, (b32_dec(X)):5>>);
decode(<<>>, Bin) -> 
    Bin.


b32_dec(I) when I >= $A andalso I =< $Z -> I - $A;
b32_dec(I) when I >= $2 andalso I =< $7 -> I - 24;
b32_dec(I) when I >= $a andalso I =< $z -> I - $a.
