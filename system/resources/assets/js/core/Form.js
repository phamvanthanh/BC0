import Errors from './Errors';

class Form {
    /**
     * Create a new Form instance.
     *
     * @param {object} data
     */
    constructor(data) {
        this.originalData = data;

        for (let field in data) {
            this[field] = data[field];
        }
        this.requestType = '';
        this.notifications = {action: null, message: null, data: null};
        this.errors = new Errors();
        let self = this;
        this.errors = Object.observe(this.errors, function(changeset){
            self.notifications.data = changeset;
        });
       
    }


    /**
     * Fetch all relevant data for the form.
     */
    data() {
        let data = {};

        for (let property in this.originalData) {
            data[property] = this[property];
        }

        return data;
    }


    /**
     * Reset the form fields.
     */
    reset() {
        for (let field in this.originalData) {
            if(field != 'timeout' && field != 'route')
            this[field] = '';
        }
        // for(let property in this.notifications){
        //     this.notifications[property] = null;
        // }

        this.errors.clear();
    }


    /**
     * Send a POST request to the given URL.
     * .
     * @param {string} url
     */
    post(url) {
        return this.submit('post', url);
    }


    /**
     * Send a PUT request to the given URL.
     * .
     * @param {string} url
     */
    put(url) {
        return this.submit('put', url);
    }


    /**
     * Send a PATCH request to the given URL.
     * .
     * @param {string} url
     */
    patch(url) {
        return this.submit('patch', url);
    }


    /**
     * Send a DELETE request to the given URL.
     * .
     * @param {string} url
     */
    delete(url) {
        return this.submit('delete', url);
    }


    /**
     * Submit the form.
     *
     * @param {string} requestType
     * @param {string} url
     */
    submit(requestType, url) {
        this.requestType = requestType;
        return new Promise((resolve, reject) => {
            axios[requestType](url, this.data())
                .then(response => {
                    // console.log(response)
                    // this.onSuccess(response.data);
                    this.log(response);
                    resolve(response.data);
                })
                .catch(error => {
                    // this.onFail(error.response.data);
                    // console.log(error.response)
                    this.log(error.response);
                    reject(error.response.data);
                });
        });
    }


    /**
     * Handle a successful form submission.
     *
     * @param {object} data
     */

        
    // }
    log(response) {
        this.notifications.status = response.status,
        this.notifications.statusText = response.statusText,
        this.notifications.data = response.data;
    }
    /**
     * Handle a failed form submission.
     *
     * @param {object} errors
     */
 

}


export default Form;