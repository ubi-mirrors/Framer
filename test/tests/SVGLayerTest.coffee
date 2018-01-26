{expect} = require "chai"

svgString = "<svg xmlns=\"http:\/\/www.w3.org\/2000\/svg\" width=\"24\" height=\"24\" viewBox=\"0 0 24 24\" fill=\"none\" stroke=\"currentColor\" stroke-width=\"2\" stroke-linecap=\"round\" stroke-linejoin=\"round\" class=\"feather feather-toggle-right\"><rect x=\"1\" y=\"5\" width=\"22\" height=\"14\" rx=\"7\" ry=\"7\"><\/rect><circle cx=\"16\" cy=\"12\" r=\"3\"><\/circle><\/svg>"
describe "SVGLayer", ->
	describe "gradients", ->
		it "should generate unique gradient id per instance", ->
			a = new SVGLayer
				gradient: new Gradient

			b = new SVGLayer
				gradient: new Gradient

			a._elementGradientSVG.innerHTML.should.not.be.equal b._elementGradientSVG.innerHTML

	describe "copying", ->
		it "should copy the html intrinsic size", ->
			a = new SVGLayer
				width: 24
				html: svgString
				htmlIntrinsicSize:
					height: 24
					width: 24
				height: 24

			b = a.copy()
			a.htmlIntrinsicSize.should.eql b.htmlIntrinsicSize
			a.destroy()

		it "should copy a SVGLayer that has no id's but does have names", ->
			svgWithNames = '<svg xmlns="http://www.w3.org/2000/svg" width="182" height="182"><path d="M 0 0 L 182 0 L 182 182 L 0 182 Z" name="Rectangle"></path></svg>'
			a = new SVGLayer
				x: 123
				y: 456
				svg: svgWithNames

			b = a.copy()
			b.html.should.equal '<svg xmlns="http://www.w3.org/2000/svg" width="182" height="182"><path d="M 0 0 L 182 0 L 182 182 L 0 182 Z" name="Rectangle" style="-webkit-perspective: none; pointer-events: none; display: block; opacity: 1; overflow: visible; -webkit-transform-style: preserve-3d; -webkit-backface-visibility: visible; -webkit-perspective-origin-x: 50%; -webkit-perspective-origin-y: 50%;"></path></svg>'
			b._elementHTML.should.not.be.equal a._elementHTML

		it "should change the id's to random id's", ->
			svgWithIds = """
				<svg xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink" width="85" height="74">
				<g>
					<defs>
						<path d="M 42.5 0 L 54.99 22.033 L 82.92 25.566 L 62.71 42.717 L 67.481 66.934 L 42.5 55.5 L 17.519 66.934 L 22.29 42.717 L 2.08 25.566 L 30.01 22.033 Z" id="shape_id_M2JpFHsBN"></path>
						<filter x="-14.9%" y="-19.7%" width="129.1%" height="138.8%" filterUnits="objectBoundingBox" id="shape_id_M2JpFHsBN_shadow_out">
							<feOffset dx="0" dy="2" in="SourceAlpha" result="shape_id_M2JpFHsBN_outer_shadow0offset"></feOffset>
							<feGaussianBlur stdDeviation="2.5" in="shape_id_M2JpFHsBN_outer_shadow0offset" result="shape_id_M2JpFHsBN_outer_shadow0blur"></feGaussianBlur>
							<feColorMatrix color-interpolation-filters="sRGB" values="0 0 0 0 0   0 0 0 0 0   0 0 0 0 0  0 0 0 0.25 0" type="matrix" in="shape_id_M2JpFHsBN_outer_shadow0blur" result="shape_id_M2JpFHsBN_outer_shadow0matrix"></feColorMatrix>
						</filter>
						<filter x="-5.8%" y="-9.4%" width="111.1%" height="118.1%" filterUnits="objectBoundingBox" id="shape_id_M2JpFHsBN_shadow_inside">
							<feGaussianBlur stdDeviation="2.5" in="SourceAlpha" result="shape_id_M2JpFHsBN_inside_shadow0blur"></feGaussianBlur>
							<feOffset dx="0" dy="2" in="shape_id_M2JpFHsBN_inside_shadow0blur" result="shape_id_M2JpFHsBN_inside_shadow0offset"></feOffset>
							<feComposite in="shape_id_M2JpFHsBN_inside_shadow0offset" in2="SourceAlpha" operator="arithmetic" k2="-1" k3="1" result="shape_id_M2JpFHsBN_inside_shadow0composite"></feComposite>
							<feColorMatrix color-interpolation-filters="sRGB" values="0 0 0 0 0   0 0 0 0 0   0 0 0 0 0  0 0 0 0.25 0" type="matrix" in="shape_id_M2JpFHsBN_inside_shadow0composite" result="shape_id_M2JpFHsBN_inside_shadow0matrix"></feColorMatrix>
						</filter>
					</defs>
					<g filter="url(#shape_id_M2JpFHsBN_shadow_out)">
						<use stroke-width="1" stroke="black" fill="black" fill-opacity="1" stroke-opacity="1" xlink:href="#shape_id_M2JpFHsBN"></use>
					</g>
					<use xlink:href="#shape_id_M2JpFHsBN" fill="#CCC" stroke-opacity="0" id="transparent"></use>
					<use fill="black" fill-opacity="1" filter="url(#shape_id_M2JpFHsBN_shadow_inside)" xlink:href="#shape_id_M2JpFHsBN"></use>
					<use xlink:href="#shape_id_M2JpFHsBN" fill="transparent" stroke-width="1" stroke="#0AF" id="CCC"></use>
				</g>
			</svg>
			"""
			a = new SVGLayer
				svg: svgWithIds
			b = a.copy()
			b.html.should.equal """
				<svg xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink" width="85" height="74">
				<g>
					<defs>
						<path d="M 42.5 0 L 54.99 22.033 L 82.92 25.566 L 62.71 42.717 L 67.481 66.934 L 42.5 55.5 L 17.519 66.934 L 22.29 42.717 L 2.08 25.566 L 30.01 22.033 Z" id="shape_id_M2JpFHsBN1"></path>
						<filter x="-14.9%" y="-19.7%" width="129.1%" height="138.8%" filterUnits="objectBoundingBox" id="shape_id_M2JpFHsBN_shadow_out1">
							<feOffset dx="0" dy="2" in="SourceAlpha" result="shape_id_M2JpFHsBN_outer_shadow0offset"></feOffset>
							<feGaussianBlur stdDeviation="2.5" in="shape_id_M2JpFHsBN_outer_shadow0offset" result="shape_id_M2JpFHsBN_outer_shadow0blur"></feGaussianBlur>
							<feColorMatrix color-interpolation-filters="sRGB" values="0 0 0 0 0   0 0 0 0 0   0 0 0 0 0  0 0 0 0.25 0" type="matrix" in="shape_id_M2JpFHsBN_outer_shadow0blur" result="shape_id_M2JpFHsBN_outer_shadow0matrix"></feColorMatrix>
						</filter>
						<filter x="-5.8%" y="-9.4%" width="111.1%" height="118.1%" filterUnits="objectBoundingBox" id="shape_id_M2JpFHsBN_shadow_inside1">
							<feGaussianBlur stdDeviation="2.5" in="SourceAlpha" result="shape_id_M2JpFHsBN_inside_shadow0blur"></feGaussianBlur>
							<feOffset dx="0" dy="2" in="shape_id_M2JpFHsBN_inside_shadow0blur" result="shape_id_M2JpFHsBN_inside_shadow0offset"></feOffset>
							<feComposite in="shape_id_M2JpFHsBN_inside_shadow0offset" in2="SourceAlpha" operator="arithmetic" k2="-1" k3="1" result="shape_id_M2JpFHsBN_inside_shadow0composite"></feComposite>
							<feColorMatrix color-interpolation-filters="sRGB" values="0 0 0 0 0   0 0 0 0 0   0 0 0 0 0  0 0 0 0.25 0" type="matrix" in="shape_id_M2JpFHsBN_inside_shadow0composite" result="shape_id_M2JpFHsBN_inside_shadow0matrix"></feColorMatrix>
						</filter>
					</defs>
					<g filter="url(#shape_id_M2JpFHsBN_shadow_out1)">
						<use stroke-width="1" stroke="black" fill="black" fill-opacity="1" stroke-opacity="1" xlink:href="#shape_id_M2JpFHsBN1"></use>
					</g>
					<use xlink:href="#shape_id_M2JpFHsBN1" fill="#CCC" stroke-opacity="0" id="transparent1"></use>
					<use fill="black" fill-opacity="1" filter="url(#shape_id_M2JpFHsBN_shadow_inside1)" xlink:href="#shape_id_M2JpFHsBN1"></use>
					<use xlink:href="#shape_id_M2JpFHsBN1" fill="transparent" stroke-width="1" stroke="#0AF" id="CCC1"></use>
				</g>
			</svg>
			"""
			a.destroy()

		it "should copy SVGLayer that has ids", ->
			a = new SVGLayer
				x: 123
				y: 456
				svg: '<svg xmlns="http://www.w3.org/2000/svg" width="100" height="100"><path d="M 100 50 C 100 77.614 77.614 100 50 100 C 22.386 100 0 77.614 0 50 C 0 22.386 22.386 0 50 0" id="path" name="path" fill="transparent" stroke="#0AF"></path></svg>'
			b = a.copy()
			expect(b.html).to.equal '<svg xmlns="http://www.w3.org/2000/svg" width="100" height="100"><path d="M 100 50 C 100 77.614 77.614 100 50 100 C 22.386 100 0 77.614 0 50 C 0 22.386 22.386 0 50 0" id="path1" name="path" fill="transparent" stroke="#0AF" style="-webkit-perspective: none; pointer-events: none; display: block; opacity: 1; overflow: visible; -webkit-transform-style: preserve-3d; -webkit-backface-visibility: visible; fill: rgba(0, 0, 0, 0); stroke: #00aaff; -webkit-perspective-origin-x: 50%; -webkit-perspective-origin-y: 50%;"></path></svg>'
			a.destroy()

	describe "initializing", ->
		it "should set clip to true by default", ->
			a = new SVGLayer
			a.clip.should.be.false
			a._element.style.overflow.should.equal("visible")

		it "should allow for overriding the clip property", ->
			a = new SVGLayer
				clip: true
			a.clip.should.be.true
			a._element.style.overflow.should.equal("hidden")

		it "should use the default backgroundColor when not providing SVG", ->
			a = new SVGLayer
			a.backgroundColor.should.equalColor Framer.Defaults.Layer.backgroundColor

		it "should set the backgroundColor to null when providing SVG", ->
			a = new SVGLayer
				svg: svgString
			expect(a.backgroundColor).to.be.null

		it "should allow overriding the backgroundColor to null when providing SVG", ->
			a = new SVGLayer
				svg: svgString
				backgroundColor: "blue"
			a.backgroundColor.should.equalColor "blue"

		it "should set the backgroundColor to null when providing SVG", ->
			a = new SVGLayer
				html: svgString
			expect(a.backgroundColor).to.be.null

		it "should warn when adding an svg string with id's that already exist in the document", ->
			svgWithIds = '<svg xmlns="http://www.w3.org/2000/svg" width="182" height="182"><path d="M 0 0 L 182 0 L 182 182 L 0 182 Z" name="Rectangle" id="test-bla/hoera"></path></svg>'
			a = new SVGLayer
				svg: svgWithIds
			b = new SVGLayer
				svg: svgWithIds
			a.html.should.equal '<svg xmlns="http://www.w3.org/2000/svg" width="182" height="182"><path d="M 0 0 L 182 0 L 182 182 L 0 182 Z" name="Rectangle" id="test-bla/hoera" style="-webkit-perspective: none; pointer-events: none; display: block; opacity: 1; overflow: visible; -webkit-transform-style: preserve-3d; -webkit-backface-visibility: visible; -webkit-perspective-origin-x: 50%; -webkit-perspective-origin-y: 50%;"></path></svg>'
			b.html.should.equal ''
			a.destroy()
			b.destroy()

		it "should warn when adding an svg element with id's that already exist in the document", ->
			svgWithIds = '<svg xmlns="http://www.w3.org/2000/svg" width="182" height="182"><path d="M 0 0 L 182 0 L 182 182 L 0 182 Z" name="Rectangle" id="test-bla/hoera"></path></svg>'
			a = new SVGLayer
				svg: svgWithIds
			b = new SVGLayer
				svg: a.svg
			a.html.should.equal '<svg xmlns="http://www.w3.org/2000/svg" width="182" height="182"><path d="M 0 0 L 182 0 L 182 182 L 0 182 Z" name="Rectangle" id="test-bla/hoera" style="-webkit-perspective: none; pointer-events: none; display: block; opacity: 1; overflow: visible; -webkit-transform-style: preserve-3d; -webkit-backface-visibility: visible; -webkit-perspective-origin-x: 50%; -webkit-perspective-origin-y: 50%;"></path></svg>'
			b.html.should.equal ''
			a.destroy()


	describe "svg", ->
		describe "getter", ->
			it "should return the SVG node", ->
				layer = new SVGLayer
					html: svgString
				layer.svg.should.be.an.instanceof(SVGElement)
			it "should return null if the layer doesn't contain a svg node", ->
				layer = new SVGLayer
					html: "<div>hallo</div>"
				expect(layer.svg).to.be.null

		describe "setter", ->
			it "should the html when a string is set", ->
				layer = new SVGLayer
					svg: svgString
				layer.html.should.equal svgString

			it "should set an svg node if an SVG element is provided", ->
				layer = new SVGLayer
					svg: svgString

				layer2 = new SVGLayer

				layer2.svg = layer.svg
				layer2.html.should.equal svgString


			it "should remove all children when setting an svg node", ->
				layer = new SVGLayer
					svg: svgString

				layer2 = new SVGLayer
					svg: svgString

				layer2.svg = layer.svg
				layer2.html.should.equal svgString

			it "should not clone the node if the provided node has no parent", ->
				svg = document.createElementNS("http://www.w3.org/2000/svg", "svg")
				svg.setAttribute('style', 'border: 1px solid black')
				svg.setAttribute('width', '600')
				svg.setAttribute('height', '250')
				svg.setAttributeNS("http://www.w3.org/2000/xmlns/", "xmlns:xlink", "http://www.w3.org/1999/xlink")
				layer2 = new SVGLayer
				layer2.svg = svg
				expect(layer2.svg is svg).to.be.true
				layer2.html.should.equal '<svg style="border: 1px solid black" width="600" height="250" xmlns:xlink="http://www.w3.org/1999/xlink"></svg>'


			it "should clone the node if the provided svg element already has a parent", ->
				layer = new SVGLayer
					svg: svgString
				layer2 = new SVGLayer
				svg = layer.svg
				layer2.svg = svg
				expect(layer2.svg is svg).to.be.false
				layer.html.should.equal svgString
				layer2.html.should.equal svgString
