# Missing

Given two file structures this program will check for files that exist in one structure but are *missing* from the second. Created to check for photos that have not be moved into a master archive before deletion.

## Itch

Lost photos! Our household has two iPhones, one Android tablet and one digital camera all of which are used to take photos. Photos are shared to Dropbox using the DropBox [Camera Upload](https://www.dropbox.com/en/help/289) functionality. Under the Dropbox top level a *Camera Upload* directory is created which is shared to each other (we have separate DropBox accounts) using a DropBox share. Whoever gets to the photos first, sorts, categorises and moves the photos to our main photo library (also shared via DropBox).

If the DropBox photo upload is cancelled part way through or something else goes wrong, Dropbox thinks it has uploaded photos when it hasn't. This means it won't touch the files on the device and the photos remain there. As Dropbox manipulates the file name on import to match the date and time, it is not possible to manually check which files have been uploaded or not.

## Scratch

This program checks if the photos (or any files) that are manually pulled from the device, exist in the main photo library. 

The ```<master library path>``` and ```<possible duplicates path>``` are passed in as command line options. New / non-duplicate files are copied to a directory named ```new``` under the possible duplicates directory. If the ```<rename flag>``` is set to ```yes``` the files are renamed to DropBox photo import file name format (```%Y-%m-%d %H.%M.%S.jpg```). For photos with EXIF date and time properties, this will be used to derive the filename as per DropBox functionality, else the file timestamp is used.


Existing / duplicate files are copied to a directory named ```duplicates``` under the ```<possible duplicates path>``` and are renamed to include the name of the master file, for example ```DSC00001.jpg duplicate of 2014-09-03 21.49.37.jpg```.


## How it works?

Files are compared using MD5 checksums. New files are optionally named using EXIF time and date properties to the DropBox photo file name format: 

```%Y-%m-%d %H.%M.%S.jpg```

Of course there are many other use cases for type of program.

If you are looking for a Ruby program to check for duplicate files and photos this [code](http://bdunagan.com/2010/08/24/dedupe-files-with-50-lines-of-ruby/) appears to work quite well.


## Usage

Organise both master library and possible new/duplicates under one top level directory structure respectively.

```bash
ruby missing.rb  -l <master library path> -d <duplicates path> -r <rename flag> 
```

The following options are available:

	-l   master / library path 
	-s   (possible) duplicates path 
	-r   flag to indicate whether to rename file to DropBox format (Y or N) 

## Limitations

Obviously if you have played around (resized, touched up, etc.) the photos before storing them in the photo archive, this method will not work. You have to get a bit cleverer in order to solve this problem (see [here](http://hackerlabs.org/blog/2012/07/30/organizing-photos-with-duplicate-and-similarity-checking/) and [here](https://github.com/HackerLabs/PhotoOrganizer)).

## Unit Tests

MiniTest unit tests can be found in the ```test``` directory.

Tests can be run using:

```bash
rake test
```

or with [Guard](https://github.com/guard/guard):

```bash
bundle exec guard
```

### Test Scenarios

The test cases utilise a set of sample photos found in:

* ```test/files/master_library```.

| File Name                | EXIF Date                   | File Date              |
|--------------------------|-----------------------------|------------------------|
| 2014-09-05 15.52.34.jpg  |                             |                        |
| 2014-09-05 19.37.17.jpg  |                             |                        |

* ```test/files/possible_dups```

When run with ```<rename flag>``` equal to ```Y```:

| File Name                | EXIF Date                   | File Date              | Duplicate of            | Resultant Filename                                          |
|--------------------------|-----------------------------|------------------------|-------------------------|-------------------------------------------------------------|
| DSC00001.jpg             |                             |                        | 2014-09-05 19.37.17.jpg | duplicates/DSC00001.jpg duplicate of 2014-09-03 21.49.37.jpg|
| DSC00002.jpg             | "2014-09-05 20:22:59 +1000" |                        | Not duplicate           | new/2014-09-05 20.22.59.jpg                                 |
| DSC00003.jpg             |  nil                        |                        | Not duplicate           | new/file date                                               |
| DSC00004.jpg             |                             |                        | 2014-09-05 15.52.34.jpg | duplicates/DSC00004.jpg duplicate of 2014-09-05 15:52.34.jpg |


## To Do

* Finalise coding
* Tests
 

## License

MIT. Use and abuse. No comeback.



