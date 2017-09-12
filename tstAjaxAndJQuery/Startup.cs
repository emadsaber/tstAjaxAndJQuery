using Microsoft.Owin;
using Owin;

[assembly: OwinStartupAttribute(typeof(tstAjaxAndJQuery.Startup))]
namespace tstAjaxAndJQuery
{
    public partial class Startup {
        public void Configuration(IAppBuilder app) {
            ConfigureAuth(app);
        }
    }
}
