
## imgqr

**version 1.0**

&nbsp;

### Decodes the QR Code(s) in the image at the specified path and outputs the retrieved data in JSON format.

&nbsp;

**Usage:**

`imgqr -img <path-to-the-image>`

&nbsp;

**Example:**

&nbsp;

```
% imgqr -img test.jpg
[
    {
        message: "https://www.example.com",
        x:       100.000000,
        y:       100.000000,
        w:       50.000000,
        h:       50.000000,
    },
    {
        message: "https://foo.bar.com",
        x:       200.000000,
        y:       200.000000,
        w:       25.000000,
        h:       25.000000,
    }
]
```

&nbsp;

#### MIT License

**Copyright © 2022 Paolo Bertani - Kalei S.r.l.**

Permission is hereby granted, free of charge, to any person
obtaining a copy of this software and associated documentation
files (the "Software"), to deal in the Software without
restriction, including without limitation the rights to use,
copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the
Software is furnished to do so, subject to the following
conditions:

The above copyright notice and this permission notice shall be
included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES
OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT
HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY,
WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
OTHER DEALINGS IN THE SOFTWARE.

