<script>
/*=============================================================================
  Created by NxtChg (admin@nxtchg.com), 2017. License: Public Domain.
=============================================================================*/

Vue.component('vs-crumbs',
{
	template:
		`<ul class="vs-crumbs" v-if="crumbs.length" style="list-style:none; margin:0; padding:0; display:inline-block;">
			  <li v-for="(crumb, i) in crumbs" style="display:inline-block">
					 <router-link v-if="i < crumbs.length" :to="crumb.path"  >{{ crumb.name | capital }} <span v-if="i > 0" class="divider"><i class="icon-arrow-right32"></i></span></router-link>
					 
        </li>
			</ul>`,

	props: { root: String },

	computed:
	{
		crumbs: function()
		{
			var path = '', title = (this.root || '');

			var cs = [ { name: title, path: '/'} ]; if(!this.$route) return [];

			var r = (this.$route.path                        ).split('/');
			var m = (this.$route.matched[0].meta.crumbs || '').split('/');

			for(var i = 1; i < r.length; i++)
			{
				var name = (m[i] || r[i]); if(r[i] == '') continue;

				// title += ' : '+ name;
				path  += '/'  + name;
                name = name.replace("_", " ");
				cs.push({ name: name, path: path });
			}

			// window.document.title = title;
			 cs.splice(-1,1)
			 return cs;
		}
  },
    filters: {
			capital: function (value) {
				return capitalize(value)
			}
  }
});
</script>
