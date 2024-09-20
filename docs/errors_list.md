# Error list for AU Core inferno tests

This document provides a list of errors that may be encountered during various tests, along with their explanations, to assist with interpretation and troubleshooting.

|Error|Reason|
|---|---|
|No Patient resources appear to be available. Please use patients with more information|Raised when resources are not found in search, read, and reference resolution tests. Resource type changed dynamically according to the context.|
|Could not find values for all search params identifier|Raised when there is no data to check the results of a search. It can be a missed attribute in the found resource or resources not found at all.|
|There are no resources of the type [resource type] from previous tests, and you didn't provide IDs to search.|Raised in the reading test when previous resources are not found and resource IDs for search are not provided|
|No [resource type] resources conforming to the [profile url] profile were returned|Validation error in the validation test. The resource type and profile URL are dynamically changed according to the context.|
|No Patient resources were found|Raised in "must support" tests when resources are not found. Resource type changed dynamically according to the context.|
|There is no reference to the target resource in the returned result|Raised in the "chain search" test when there is no reference to the target resource in the result.|
|Insufficient number of values for the search. The number of values should be more than 1. The current number of values is 0.|Raised in the "multiple search" tests when existing values number for search less than 2|
|Inconsistent state of the test (params to search more than 2)|Raised in the "multiple search" tests when the number of  search params is more than 2|
|Inconsistent state of the test (number of params to search is 0)|Raised in the "multiple search" tests when the number of  search params is 0|