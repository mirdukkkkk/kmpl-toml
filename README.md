# kmpl-toml

A TOML reader for [kmpl](https://github.com/mirdukkkkk/kmpl), written in kmpl.
It needs kmpl 0.3.0 or newer.

```sh
kmpl add https://github.com/mirdukkkkk/kmpl-toml/v0.0.1
```

This adds it under the name `kmpl-toml`, pinned in `kmpl.lock`.

```text
import (parse, get, as_int, as_text, Result) from "kmpl-toml";

fn main() {
    match parse("[server]\nport = 8080") {
        Result::Ok(doc) => {
            print(doc.get("server.port").as_int());  // some(8080)
            print(doc.get("server.host").as_text().unwrap_or("local"));  // local
        }
        Result::Err(message) => { panic(message); }
    }
}
```

## What it reads

Strings (basic and literal, one line), integers, reals, booleans, arrays over
several lines, `[tables]`, dotted and quoted keys, comments. An error says which
line it is on.

Dates, inline tables, multi-line strings and arrays of tables are refused.

## Functions

| Function | Gives |
|---|---|
| `parse(text)` | `Result<Value, string>` |
| `get(value, "a.b")` | `Value?` |
| `as_text as_int as_real as_bool as_array` | `T?`, `none` for another type |
| `keys(value)` | `[string]?`, in the order of the file |

`as_real` also accepts an integer. They all take a `Value?`, so they chain after
`get`.

## Development

`nix develop -c kmpl tests/main.kmpl`, from the root of the repository.

## License

MIT OR Apache-2.0
