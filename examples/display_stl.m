% example usage to demonstrate displaying an STL file.
% created by umhau on 3.29.16

filename = 'raiderasm.stl';
plot_graph = true;
trans = [0,0,0];
rotation = [0,180,0];


obj = PlotSTL(filename, plot_graph, trans, rotation);
