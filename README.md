# Laravel Backend

How to run on local using php astrin
1. composer install
2. Run git clone
3. php artisan serve

How to set up on your local machine using XAMPP

1. Run git clone
2. Open up the following file in notepad(++): D:\xampp\apache\conf\extra\httpd-vhosts.conf
3. Add the following lines to this file: 

    ```
    <VirtualHost *:80>
        ServerAdmin info@example.com
        DocumentRoot "D:\xampp\htdocs\laravel-admin"
        ServerName example.com
        ServerAlias www.example.com
        <Directory "D:\xampp\htdocs\laravel-admin">
            Options Indexes FollowSymLinks
            AllowOverride All
            Require all granted
        </Directory>
    </VirtualHost>
    ```

4. Open Notepad in Administrator mode
5. With Notepad, open up the following file: C:\Windows\System32\drivers\etc\hosts
6. Add the following line:

    ```
   127.0.0.1       example.com
    ```

7. Start XAMPP and you should be able to connect with the local

8. Run example.com on browser

It important to push your code EVERY day to github. 

Username: admin@laravel.com
Password: Admin@123
