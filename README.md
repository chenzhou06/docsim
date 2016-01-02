# A Naive Document Similarity Calculator in Racket

## Feature

* Poorly tested.
* Lack of comment.
* Have no idea about the correctness.

## Formula

$$ \arccos(\frac{a^Tb}{||a||\cdot ||b||} $$ where $a$ is the vector
representing file0, $b$ file1. The return is show as degrees.


## Usage

```shell
$ docsim file0 file1
```
