1M records inserted in 22 minutes works out to be 758 records/second. Each INSERT here is an individual commit to disk, with both write-ahead log and database components to it eventually. Normally I expect that even good hardware with a battery-backed cache and everything you will be lucky to hit 3000 commit/second. So you're not actually doing too bad if this is regular hardware without such write acceleration. The normal limit here is in the 500 to 1000 commits/second range in the situation you're in, without special tuning for this situation.

As for what that would look like, if you can't make the commits include more records each, your options for speeding this up include:

- Turn off synchronous_commit (already done)
    
- Increase wal_writer_delay. When synchronous_commit is off, the database spools commits up to be written every 200ms. You can make that some number of seconds instead if you want to by tweaking this upwards, it just increases the size of data loss after a crash.
    
- Increase wal_buffers to 16MB, just to make that whole operation more efficient.
    
- Increase checkpoint_segments, to cut down on how often the regular data is written to disk. You probably want at least 64 here. Downsides are higher disk space use and longer recovery time after a crash.
    
- Increase shared_buffers. The default here is tiny, typically 32MB. You have to increase how much UNIX shared memory the system has to allocate. Once that's done, useful values are typically >1/4 of total RAM, up to 8GB. The rate of gain here falls off above 256MB, the increase from the default to there can be really helpful though.