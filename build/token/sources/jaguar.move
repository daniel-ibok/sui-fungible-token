module token::jaguar;

use sui::coin::{Self, Coin, TreasuryCap};
use sui::url;

public struct JAGUAR has drop {}

fun init(witness: JAGUAR, ctx: &mut TxContext) {
    let (treasury, metadata) = coin::create_currency(
        witness,
        8,
        b"JAGR",
        b"JAGUAR",
        b"STH IN BETWEEN",
        option::some(url::new_unsafe_from_bytes(b"https://i.pinimg.com/736x/8b/3c/27/8b3c2797b8d23fc0d99d77312bd58189.jpg")),
        ctx
    );

    // make metadata for token immutable
    transfer::public_freeze_object(metadata);

    // transfer trasury capability to token creator to mint/burn
    transfer::public_transfer(treasury, tx_context::sender(ctx));
}

/// mint fungible token
public entry fun mint(treasuryCap: &mut TreasuryCap<JAGUAR>, amount: u64, recipient: address, ctx: &mut TxContext) {
    coin::mint_and_transfer(treasuryCap, amount, recipient, ctx);
}

/// burn fungible tokens
public entry fun burn(trasuryCap: &mut TreasuryCap<JAGUAR>, coin: Coin<JAGUAR>) {
    coin::burn(trasuryCap, coin);
}











