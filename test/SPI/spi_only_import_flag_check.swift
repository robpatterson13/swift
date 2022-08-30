/// Test requiring the flag -experimental-spi-only-imports to use @_spiOnly.

// RUN: %empty-directory(%t)
// RUN: split-file %s %t

/// Build dummy dependency.
// RUN: %target-swift-frontend -emit-module %t/Empty.swift \
// RUN:   -module-name Empty -emit-module-path %t/Empty.swiftmodule

/// Attribute is rejected without the flag.
// RUN: %target-swift-frontend -emit-module %t/Client.swift -I %t \
// RUN:   -module-name Client -emit-module-path %t/Client.swiftmodule -verify

/// Attribute is accepted with the flag.
// RUN: %target-swift-frontend -emit-module %t/Client.swift -I %t \
// RUN:   -module-name Client -emit-module-path %t/Client.swiftmodule \
// RUN:   -experimental-spi-only-imports

//--- Empty.swift
//--- Client.swift

@_spiOnly import Empty // expected-error {{'@_spiOnly' requires setting the frontend flag '-experimental-spi-only-imports'}}
