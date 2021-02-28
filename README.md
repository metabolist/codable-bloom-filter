# CodableBloomFilter

An implementation of the [Bloom filter](https://en.wikipedia.org/wiki/Bloom_filter) data structure conforming to Swift's `Codable` serialization protocol.

- [Installation](#installation)
- [Usage](#usage)
- [License](#license)

## Installation

### Swift Package Manager

Add a dependency to `https://github.com/metabolist/codable-bloom-filter.git`, either in Xcode or by adding it to the `dependencies` array in your `Package.swift`:

```swift
dependencies: [
    .package(name: "CodableBloomFilter", url: "https://github.com/metabolist/codable-bloom-filter.git", .upToNextMajor(from: "1.0.0"))
],
```

### CocoaPods

Add the following to your `Podfile`:

```ruby
pod 'CodableBloomFilter', '~> 1.0'
```

## Usage

For a type to be usable in a bloom filter, it must conform to the `DeterministicallyHashable` protocol. An implemenation for `Data` and `String` is included.

Bloom filters are initialized with a set of hash functions and a count of bytes to use. CodableBloomFilter provides 5 different hash functions (32-bit versions of DJB2, DJB2a, SDBM, FNV1, and FNV1a). For determining the number of hash functions and size for your use case, see https://en.wikipedia.org/wiki/Bloom_filter#Optimal_number_of_hash_functions.

Note that while a size of 8 bytes is used in the following examples to keep the output readable, in practice you will likely want something larger.

A bloom filter can be used similarly to a `Set`:
```swift
import CodableBloomFilter

var bloomFilter = BloomFilter<String>(hashes: [.sdbm32, .djb232], byteCount: 8)

bloomFilter.insert("string")

bloomFilter.contains("string") // returns true
bloomFilter.contains("other string") // returns false
```

To serialize a bloom filter:
```swift
let data = try JSONEncoder().encode(bloomFilter)
// `data` will be JSON data equivalent to "{"hashes":["djb232","sdbm32"],"data":"AAAAAAAAAhA="}"
```

To deserialize a bloom filter:
```swift
let bloomFilter = try JSONDecoder().decode(BloomFilter<String>.self, from: data)
```

Using a custom `dataEncodingStrategy` / `dataDecodingStrategy` is supported. For example, to have the data serialized as a hexadecimal string:

```swift
let encoder = JSONEncoder()

encoder.dataEncodingStrategy = .custom { data, encoder in
    var container = encoder.singleValueContainer()

    try container.encode(data.map { String(format: "%02.2hhx", $0) }.joined())
}

let data = try encoder.encode(bloomFilter)
// `data` will be JSON data equivalent to "{"hashes":["djb232","sdbm32"],"data":"0000000000000210"}"
```

Bloom filters can also be initialized from `Data`. To initialize the bloom filter above:
```swift
let bloomFilter = BloomFilter<String>(hashes: [.sdbm32, .djb232], data: Data([0, 0, 0, 0, 0, 0, 2, 16]))
```

A bloom filter's data can be accessed via its `data` property:
```swift
let data = bloomFilter.data // `data` will be equivalent to `Data([0, 0, 0, 0, 0, 0, 2, 16])`
```

## License

CodableBloomFilter is released under the MIT license. [See LICENSE](https://github.com/metabolist/codable-bloom-filter/blob/main/LICENSE) for details.
