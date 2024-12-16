module token::nature;

use sui::coin::{Self, Coin, TreasuryCap};
use sui::url;

public struct NATURE has drop {}

fun init(witness: NATURE, ctx: &mut TxContext) {
    let (treasury, metadata) = coin::create_currency(
        witness,
        8,
        b"NATR",
        b"NATURE",
        b"EMBRACE NATURE :)",
        option::some(url::new_unsafe_from_bytes(b"https://i.pinimg.com/736x/78/94/ab/7894ab7662e0bffdaf29a356432b3767.jpg")),
        ctx
    );

    // make metadata for token immutable
    transfer::public_freeze_object(metadata);

    // transfer trasury capability to token creator to mint/burn
    transfer::public_transfer(treasury, tx_context::sender(ctx));
}

/// mint fungible token
public entry fun mint(treasuryCap: &mut TreasuryCap<NATURE>, amount: u64, recipient: address, ctx: &mut TxContext) {
    coin::mint_and_transfer(treasuryCap, amount, recipient, ctx);
}

/// burn fungible tokens
public entry fun burn(trasuryCap: &mut TreasuryCap<NATURE>, coin: Coin<NATURE>) {
    coin::burn(trasuryCap, coin);
}











