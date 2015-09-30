# Hospital

Hospital is the UI and APIs behind Medic, the daemon can be found at [doomspork/medic](https://github.com/doomspork/medic).

## Usage

1. Install dependencies
	
		$ mix deps.get
		$ npm install

1. Create and migrate the database:

		$ mix ecto.create && mix ecto.migrate
		
1. Run the server:

		$ mix phoenix.server

1. Now you can visit [`localhost:4000`](http://localhost:4000) from your browser.


## Endpoints

These endpoints all require a session. If the event that the user is not logged in the response will be 401 `{"error": "Login required"}`.

### Accounts

+ #### GET `/account`

	Get the current user's account, this can be used to check for logged in status.
 
  	__Response__
 
 	```json
	{  
  		"data": {  
    		"id": 1,
    		"name": "Real Name",
    		"email": "user@example.com"
  		}
	}
 	```
 	
+ #### POST `/login`

	Login a user given an email and password.

 	__Request__
  	
  	```json
	{  
    	"email": "user@example.com",
    	"password": "a strong password"
	}
 	```
 	
 	__Response__
 
 	```json
	{  
  		"data": {  
    		"id": 1,
    		"name": "Real Name",
    		"email": "user@example.com"
  		}
	}
 	```
 
+ __DELETE `/logout`__

	Log out the of the current session.
 	
### Health Checks

+ #### GET `/health_checks`

	Retrieve the current user's health checks.

	__Response__
 
 	```json
 	{  
 		"data": [{  
			"id": 1,
			"name": "Example.com Ping",
			"target": "http://example.com",
			"type": "ping",
			"options" : { }
    	}]
	}
 	```
 	
+ #### GET `/health_checks/:id`

	Retrieve a specific health check for a user.

 	__Response__
  
	```json
 	{  
  		"data": {  
    		"id": 1,
    		"name": "Example.com Ping",
    		"target": "http://example.com",
    		"type": "ping",
    		"options": { }
  		}
	}

+ #### PUT `/health_checks/:id`

	Update the health check if it's owned by the user.
 
  	__Response__
 
	```json
 	{  
  		"data": {  
    		"id": 1,
    		"name": "Example.com Ping",
    		"target": "http://example.com",
    		"type": "ping",
    		"options": { }
  		}
	}
		 	
+ #### DELETE `/health_checks/:id`

	Delete health check belonging to the current user.
 
  	__Response__
 
	```json
 	{  
  		"data": {  
    		"id": 1,
    		"name": "Example.com Ping",
    		"target": "http://example.com",
    		"type": "ping",
    		"options": { }
  		}
	}
 	```

## Contributing

We appreciate and welcome community feedback and contributions, please make use of [Issues](https://github.com/doomspork/hospital/issues) and [Pull Requests](https://github.com/doomspork/hospital/pulls).  

All code should have accompanying tests.


## License

The Medic logo is of copyright (c) 2015 [Utensils.io]()

Medic and Hospital source code is released under Apache 2 License.

Check [LICENSE](LICENSE) files for more
information.