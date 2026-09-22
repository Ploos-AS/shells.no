# Deployment

Deployment automation starts in M1.

Any node deployment must be reproducible from a documented Linux baseline, keep secrets outside Git, support safe repeat runs, isolate customers, enable resource limits before public provisioning, and provide tested operator recovery access.

The first implementation should optimize for a simple inexpensive VPS rather than introduce a cluster orchestrator prematurely.
