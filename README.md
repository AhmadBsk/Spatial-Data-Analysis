# Spatial-Data-Analysis
Applied Spatial Data Analysis in geoscience

##**1)Data**
Our geological and mineral data includes the following:
sediment samples 
drilling 
trenches
IP/RS profiles
faults map
Geological map (lithology, dike, ...)

*sample location*:

![image](https://user-images.githubusercontent.com/123794462/216260333-6eef68ad-1935-4a64-b5bc-7f4db3cde279.png)

`Plot+legend+Grid...{R}`

![image](https://user-images.githubusercontent.com/123794462/216262891-73130bc6-3a49-4923-a971-c258bd452ca0.png)

`geom_point {ggplot2}`


*2D Show (x.y, sediment samples,trenches,IP/RS profiles,...)*

![image](https://user-images.githubusercontent.com/123794462/216263582-8cc634bc-3170-4b75-94c0-87f77af7d6a5.png)

`geom_point {ggplot2}`

![image](https://user-images.githubusercontent.com/123794462/216263689-95a955ac-7ed2-4267-aba6-9c151d3db447.png)

`geom_bin_2d {ggplot2}`

![image](https://user-images.githubusercontent.com/123794462/216263304-1fb34f9a-c8ae-42e7-b7ed-ee8561922549.png)

`geom_raster {ggplot2}`

![image](https://user-images.githubusercontent.com/123794462/216263415-c8b0cbe0-629b-4437-b63c-e74e16624b1b.png)

`geom_point {ggplot2}`

![image](https://user-images.githubusercontent.com/123794462/216268512-bde51728-87d7-4f60-8836-78ccf85a4edc.png)

`data.frame,geom_point,scale_color {ggplot2}`

![image](https://user-images.githubusercontent.com/123794462/216270073-1232563b-60b9-481e-86ba-a94209918d8e.png)

`mapView {mapview}`

*3D Show (x.y.z,drilling,...)*

![image](https://user-images.githubusercontent.com/123794462/216263958-bd8dd076-7400-4fca-95ef-55f10ea75cf7.png)

`scatterplot3d {scatterplot3d}`

![image](https://user-images.githubusercontent.com/123794462/216264569-c15a2d73-b08d-4542-9728-900373a82732.png)

`plot3D {plot3D}`

![image](https://user-images.githubusercontent.com/123794462/216264650-f2513a69-dd7a-4bd0-a6b5-663bd97fd8ce.png)

`plotly {plotly}`

*level plot 3D Show (x.y.z,3d model,3d kriging,...)*

![image](https://user-images.githubusercontent.com/123794462/216267450-0c89803c-cb90-4f5d-a4b2-eee494b02302.png)
![image](https://user-images.githubusercontent.com/123794462/216267590-49225dbe-5afa-4b74-a1d8-4865108ea6af.png)

![image](https://user-images.githubusercontent.com/123794462/216267617-baa373a7-fb22-416d-9d13-b08784b9f32e.png)
![image](https://user-images.githubusercontent.com/123794462/216267644-978191a5-8c40-4cf8-aaec-d39d58a2a885.png)

`Levelplot,contourplot,cloud,wireframe{gstat}`


##**2)Data Parameter**

![image](https://user-images.githubusercontent.com/123794462/216269506-3abd24e8-8516-465d-b665-8f1b34d354a1.png)

![image](https://user-images.githubusercontent.com/123794462/216269714-1c611334-cf97-4f6d-8e05-de31ec2250c5.png)

`Desc {DescTools}`

![image](https://user-images.githubusercontent.com/123794462/216269780-4f259761-300c-49e9-b1f3-ce4cd7eefd85.png)

`geom_histogram{ggplot2}`

##**3)Data Analysis**

![image](https://user-images.githubusercontent.com/123794462/216270769-57b4bbf3-0282-4c7a-8abc-c8e6947bc371.png)

`qqnorm {stats}`

![image](https://user-images.githubusercontent.com/123794462/216270987-53ad0d27-6358-44b8-9f11-5fd994059cf7.png)

`classIntervals {classInt}`

![image](https://user-images.githubusercontent.com/123794462/216271448-40587462-2bf8-4d75-95ea-58b4cc727974.png)

`trend analysis`


##**4)Geostatistics**

*The empirical variogram and variogram Cloud*

![image](https://user-images.githubusercontent.com/123794462/216273360-6ce1491d-4fa7-4f27-8f94-de3691d8f94b.png)
![image](https://user-images.githubusercontent.com/123794462/216301938-ecdf5565-b8da-4ecf-b588-c62f5a416715.png)

`variogram {gstat}`

*Generates a variogram model and Fit ranges, sills, nugget*

![image](https://user-images.githubusercontent.com/123794462/216273556-e55e833f-eaac-495f-bdf9-b86dec988a2d.png)
![image](https://user-images.githubusercontent.com/123794462/216273582-c99610ce-5602-4cb7-846d-52eb0f12c665.png)

SSE of manual fit is 0.01252028 and automatic fit  is 0.005756448 `vgm {gstat}, fit.variogram {gstat}`

##**5)interpolation**

![image](https://user-images.githubusercontent.com/123794462/216300611-aa6cffaa-5cfc-4a06-8f0c-ee5f5a812afc.png)

*interpolation methods*

###**idw**
![image](https://user-images.githubusercontent.com/123794462/216302532-4670478b-a542-47fc-8247-246724b96c75.png)

*idw =  function for inverse distance weighted interpolation, Idp = numeric; specify the inverse distance weighting power*

![image](https://user-images.githubusercontent.com/123794462/216303061-d9565583-11fb-4a78-a8c5-b6606359c596.png)

`idw{gstat}, idp = 2,krige {gstat}, spplot {raster}, resolution is 100*100`

###**kriging
![image](https://user-images.githubusercontent.com/123794462/216303229-0815f1cb-4f1a-4176-9d69-6bf9f481db13.png)

`krige {gstat}, spplot {raster}, resolution is 100*100`

![image](https://user-images.githubusercontent.com/123794462/216303446-7b5709cb-dbd8-40d5-9f12-3915026c9eb0.png)

`krige {gstat}, spplot {raster}, st_crop {sf}, resolution is 718*836`

![image](https://user-images.githubusercontent.com/123794462/216304019-a64dc23c-7e83-475d-b405-646cd7390af9.png)

`krige {gstat}, geom_stars {stars}, st_crop {sf}, resolution is 718*836`

![image](https://user-images.githubusercontent.com/123794462/216304150-2e465c0d-5d9c-4169-af15-fb1f3db365a9.png)

`plot_ly {plotly}` *3D visualization*

![image](https://user-images.githubusercontent.com/123794462/216304414-68ac533a-dbf3-4b31-8c25-eaf02c80c369.png)

`raster {raster}, KML {raster}` *used by Google Earth*



