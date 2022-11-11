#!/usr/bin/swift

import Foundation

let path = "/Path/To/Folder"

nftw(path, { child, _, type, _ in
    if (type == FTW_F) { // file
      unlink(child)
    } else if (type == FTW_DP) { // directory "where we have visited children"
      rmdir(child)
    } else if (type == FTW_SL || type == FTW_SLN) { // symlink
      unlink(child)
    } else { // anything else, assume some kind of permission issue or similar
      print("Cannot delete \(String(cString: child!))")
      return 1 // error
    }
    return 0 // no error
  },
  42, // how many file descriptors should we use?
  FTW_PHYS | FTW_DEPTH // do not follow symlinks and do a "depth first" scan (files are provided before their parent dir)
)
