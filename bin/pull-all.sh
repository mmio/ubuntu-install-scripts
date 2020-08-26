#!/bin/bash
ls ~/Repos/ -1 | xargs -P0 -I{} git -C ~/Repos/{} pull
