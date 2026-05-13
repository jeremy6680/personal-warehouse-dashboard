<script>
	import '@evidence-dev/tailwind/fonts.css';
	import '../app.css';
	import { EvidenceDefaultLayout } from '@evidence-dev/core-components';
	export let data;
</script>

<EvidenceDefaultLayout {data} title="Médiathèque de Jeremy" homePageName="Accueil">
	<slot slot="content" />
</EvidenceDefaultLayout>
