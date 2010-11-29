# Creates a virtual host for nginx

hosts_file = "/etc/hosts"
vhosts_dir = "/opt/nginx/conf/vhosts"
projects_dir = "/Users/ankane/Projects"

# you shouldn't need to edit anything below this line

app_name, host = ARGV

unless host and app_name
  abort "Usage: sudo ruby vhost.rb app-name development-host"
end

%x[sudo echo '127.0.0.1       #{host}' | sudo tee -a #{hosts_file}]

conf = <<-CONF
server {
    listen 80;
    server_name #{host};
    root #{projects_dir}/#{app_name}/public;
    passenger_enabled on;
    rack_env development;
}
CONF

%x[sudo echo '#{conf}' | sudo tee #{vhosts_dir}/#{app_name}.conf]

%x[sudo nginx -s reload]
